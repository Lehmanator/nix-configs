{
  description =
    "Personal Nix / NixOS configs, along with custom NixOS modules, packages, libs, & more!";
  outputs =
    { self, nixpkgs, nixos, home, nur, flake-parts, std, omnibus, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (omnibus.flake.inputs) climodSrc;
      systems = [ "x86_64-linux" "aarch64-linux" "riscv64-linux" ];
      blockTypes = lib.recursiveUpdate
        inputs.std.blockTypes # anything, arion, containers, data, devshells, files, functions, installables, kubectl, microvms, namaka, nixago, nixostests, nomad, nvfetcher, pkgs, runnables, terra

        inputs.hive.blockTypes
        # {colemna,darwin,disko,home,nixos}Configurations
      ;
      omnibusStd = (omnibus.pops.std {
        inputs.inputs = { inherit (omnibus.flake.inputs) std; };
      }).exports.default;
      #flake-parts.lib.mkFlake { inherit inputs; } {
    in
    omnibus.flake.inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      inherit systems;
      imports = [
        #inputs.std.flakeModule
        omnibusStd.flakeModule
        ./profiles/flakes
      ];

      std.std = omnibusStd.mkStandardStd {
        cellsFrom = ./nix;
        inherit systems;
        inputs = inputs // { inherit climodSrc; };
        nixpkgsConfig = { allowUnfree = true; };
      };
      #std.grow = {
      #  #cellsFrom = inputs.self + /nix;
      #  #cellsFrom = ../../nix;
      #  cellBlocks = with blockTypes; [
      #    #cellBlocks = with inputs.std.blockTypes; with inputs.hive.blockTypes; [
      #    (blockTypes.installables "packages" { ci.build = true; })
      #    (blockTypes.devshells "shells" { ci.build = true; })
      #    (blockTypes.functions "devshellProfiles")
      #    #(containers "containers" {ci.publish = true;})
      #    #(colmenaConfigurations "colmenaConfigurations")
      #    #(darwinConfigurations "darwinConfigurations")
      #    (blockTypes.diskoConfigurations)
      #    (blockTypes.functions "diskoProfiles")
      #    #(homeConfigurations "homeConfigurations")
      #    #(nixosConfigurations "nixosConfigurations")
      #    (blockTypes.functions "nixosProfiles")
      #    (blockTypes.functions "nixosModules")
      #    #(functions "nixosSuites")
      #    #(functions "homeProfiles")
      #    #(functions "homeModules")
      #    #(functions "blockTypes")
      #    (nixago "configs")
      #  ];
      #};

      # Harvest: Standard outputs into Nix-CLI-compatible form (aka 'official' flake schema)
      std.harvest = {
        diskoConfigurations = [ "hive" "diskoConfigurations" ];
        devShells =
          [ [ "repo" "shells" ] [ "hive" "shells" ] [ "kube" "shells" ] ];
        nixago = [ "repo" "configs" ];
        nixosModules = [ "hive" "nixosModules" ];
        packages = [
          [
            "repo"
            "packages"
          ]
          # a list of lists can "harvest" from multiple cells
          [ "hive" "packages" ]
          [ "kube" "packages" ]
        ];
      };

      # Pick: Like `harvest` but remove the system for outputs that are system agnostic.
      std.pick = {
        #lib = [["hive" "lib"]];
        #lib = [ "utils" "library" ];
        pops = [ "hive" "pops" ];
        devshellProfiles = [ [ "repo" "devshellProfiles" ] ];
        diskoProfiles = [ [ "hive" "diskoProfiles" ] ];
        #nixosModules = [
        #  [ "repo" "nixosModules" ]
        #  [ "hive" "nixosModules" ]
        #  [ "kube" "nixosModules" ]
        #];
        nixosProfiles = [
          [ "hive" "nixosProfiles" ]
          [ "kube" "nixosProfiles" ]
          [ "repo" "nixosProfiles" ]
        ];
      };
      # Winnow: Like `harvest`, but with filters from the predicates of `winnowIf`.
      #std.winnow = {
      #  packages = [ "app3" "packages" ];
      #};
      # WinnowIf: Set the predicates for `winnow`.
      #std.winnowIf = {
      #  packages = n: v: n=="foo";
      #};
      perSystem = { config, lib, pkgs, system, final, inputs', ... }: {
        packages = {
          #system-repl = pkgs.callPackage ./pkgs/nixos/system-repl {};
          #firefox-gnome-theme = pkgs.callPackage ./pkgs/nixos/themes/firefox-gnome-theme.nix {};
          #  #fajita-images = self.flake.nixosConfigurations.fajita.config.mobile.outputs.android-fastboot-images;
          deploy =
            nixpkgs.legacyPackages.${system}.writeText "cachix-deploy.json"
              (builtins.toJSON {
                agents = inputs.nixpkgs.lib.mapAttrs
                  (host: cfg: cfg.config.system.build.toplevel)
                  (inputs.nixpkgs.lib.filterAttrs
                    (host: cfg:
                      cfg ? config && cfg.config ? system && cfg.config.system
                      ? build && cfg.config.system.build ? toplevel
                      && cfg.pkgs.stdenv.buildPlatform.system == system
                      && cfg.config.services.cachix-agent.enable)
                    self.nixosConfigurations);
              });
        };
      };
      flake =
        let
          mkSystem =
            { host
            , system ? "x86_64-linux"
            , user ? "sam"
            , modules ? [ ]
            , ...
            }@args:
            #inputs.self.lib.nixos.lehmanatorSystem {
            (import ./nix/hive/lib/lehmanatorSystem.nix {
              inherit inputs self;
            }) {
              #inputs.nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs user;
                # Instantiate all instances of nixpkgs in flake.nix to avoid creating new nixpkgs instances
                # for every `import nixpkgs` call within submodules/subflakes. Saves time & RAM.
                #  See:
                #  - https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
                #  - https://nixos-and-flakes.thiscute.world/nixpkgs/multiple-nixpkgs
                # stable, unstable, master, staging, staging-next
                pkgs-master = import inputs.nixpkgs-master {
                  inherit system;
                  config.allowUnfree = true;
                };
              };
              #// specialArgs;
              modules = [ ./hosts/${host} ] ++ modules;
            };
        in
        {
          blockTypes = {
            std = inputs.std.blockTypes;
            hive = inputs.hive.blockTypes;
            #all = blockTypes;
          };
          #overlays = import ./overlays/nixos;
          nixosConfigurations = {
            fw = mkSystem { host = "fw"; };
            wyse = mkSystem { host = "wyse"; };
            fajita = nixos.lib.nixosSystem {
              system = "aarch64-linux";
              specialArgs = {
                inherit inputs;
                user = "sam";
              };
              modules = [
                {
                  _module.args = {
                    inherit inputs;
                    user = "sam";
                  };
                }
                (import "${inputs.mobile-nixos}/lib/configuration.nix" {
                  device = "oneplus-fajita";
                })
                ./hosts/fajita
                inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
              ];
            };
            fajita-minimal = nixos.lib.nixosSystem {
              system = "aarch64-linux";
              specialArgs = {
                inherit inputs;
                user = "sam";
              };
              modules = [
                {
                  _module.args = {
                    inherit inputs;
                    user = "sam";
                  };
                }
                (import "${inputs.mobile-nixos}/lib/configuration.nix" {
                  device = "oneplus-fajita";
                })
                ./hosts/fajita/minimal.nix
                inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
              ];
            };
          };
          #homeConfigurations = {
          #  sam = inputs.home.lib.homeManagerConfiguration {
          #    #pkgs = nixpkgs.legacyPackages.x86_64-linux;
          #    modules = [ ./users/sam ];
          #    extraSpecialArgs = { inherit inputs; user = "sam"; };
          #  };
          #  guest = inputs.home.lib.homeManagerConfiguration {
          #    pkgs = nixpkgs.legacyPackages.x86_64-linux;
          #    #modules = [./users/default];
          #    extraSpecialArgs = { inherit inputs; user = "guest"; };
          #  };
          #};
        };
    };

  # --- Disko ---
  # TODO: [Disko UI](https://gist.github.com/Mic92/b5b592c0c33d720cb07a070cb8911588)
  # TODO: [Disko `nix run`](https://github.com/nix-community/disko/pull/78)
  #
  # Write disk by running command:
  #   `nix run .#nixosConfigurations.<host>.config.system.build.diskoNoDeps`
  # before running:
  #   `nixos-install --flake .#<host>`
  #
  #// inputs.flake-utils.lib.eachDefaultSystem (system:
  #let
  #  pkgs = nixpkgs.legacyPackages.${system};
  #  hosts = pkgs.lib.filterAttrs
  #    (_: value:
  #      value.pkgs.system == system &&
  #      builtins.hasAttr "diskoNoDeps" value.config.system.build
  #    )
  #    self.nixosConfigurations;
  #in
  #if (hosts == { }) then { } else {
  #  apps.disko = pkgs.lib.genAttrs (builtins.attrNames hosts) (name:
  #    {
  #      program = "${self.nixosConfigurations.${name}.config.system.build.diskoNoDeps}";
  #      type = "app";
  #    });
  #});

  nixConfig = {
    connect-timeout = 10;
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
      "https://lehmanator.cachix.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU="
    ];
  };

  inputs = {
    # +-- NixOS ---------------------------------------------------------------+
    # | Branches: nixpkgs |                                                    |
    # +-------------------+                                                    |
    # | https://discourse.nixos.org/t/differences-between-nix-channels/13998   |
    # | release-YY.MM: Stable release branches of nixpkgs.                     |
    # |   nixos-YY.MM: Stable release branches of nixpkgs.                     |
    # | nixpkgs-unstable:                                                      |
    # |   nixos-unstable:                                                      |
    # |          staging:                                                      |
    # |          staging-next:                                                 |
    # +------------------------------------------------------------------------+
    # | mobile-nixos:   NixOS for mobile devices.                              |
    # | nixos-hardware: nixosModules for various hardware configurations.      |
    # | patchelf:                                                              |
    # +------------------------------------------------------------------------+
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable"; # /gnome";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    patchelf = {
      url = "github:NixOS/patchelf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # +-- nix-community -------------------------------------------------------+
    # | home-manager: Home environments in Nix.                                |
    # | nixos-generators: NixOS generators for various formats.                |
    # | dream2nix: flake-parts module to                                       |
    # +------------------------------------------------------------------------+
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dream2nix.url = "github:nix-community/dream2nix";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    harmonia = {
      url = "github:nix-community/harmonia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    namaka = {
      url = "github:nix-community/namaka";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    napalm = {
      url = "github:nix-community/napalm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-github-actions = {
      url = "github:nix-community/nix-github-actions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-init = {
      url = "github:nix-community/nix-init";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-melt = {
      url = "github:nix-community/nix-melt";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # TODO: Install package
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixdoc = {
      url = "github:nix-community/nixdoc";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # TODO: Install pkg
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-images.url = "github:nix-community/nixos-images";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixt = {
      url = "github:nix-community/nixt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nur-update.url = "github:nix-community/nur-update"; # nur-update: Update NUR
    nurl = {
      url = "github:nix-community/nurl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    patsh = {
      url = "github:nix-community/patsh";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # TODO: Install pkg
    rnix-parser = {
      url = "github:nix-community/rnix-parser";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # TODO: Install pkg
    srvos.url = "github:nix-community/srvos";
    terraform-providers = {
      url = "github:nix-community/nixpkgs-terraform-providers-bin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- MacOS ----------------------------------------------------
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # --- Mobile ---------------------------------------------------
    #mobile-nixos = { url = "github:NixOS/mobile-nixos/development"; flake = false; };
    nixpkgs-gnome-mobile.url = "github:lehmanator/nixpkgs-gnome-mobile/develop";
    nixos-mobile = {
      url = "github:vlinkz/mobile-nixos/gnomelatest";
      flake = false;
    }; # url = "github:NixOS/mobile-nixos";
    mobile-nixos = {
      url = "github:lehmanator/mobile-nixos/update-firmware";
      flake = false;
    };

    # --- Modules: Flake-parts -------------------------------------
    agenix-shell.url = "github:aciceri/agenix-shell";
    ez-configs.url = "github:ehllie/ez-configs";
    nix-cargo-integration.url = "github:yusdacra/nix-cargo-integration";
    ocaml-flake.url = "github:9glenda/ocaml-flake";
    pydev.url = "github:oceansprint/pydev";

    # --- Modules: System ------------------------------------------
    fprint-clear.url = "github:nixvital/fprint-clear";

    # --- Modules: Secrets -----------------------------------------
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scalpel = {
      url = "github:polygon/scalpel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # +-- Nix Utils -----------------------------------------------------------+
    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    debnix.url = "github:ngi-nix/debnix";
    declarative-flatpak = {
      url = "github:GermanBread/declarative-flatpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-auto-changelog = {
      url = "github:loophp/nix-auto-changelog";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-portable = {
      url = "github:DavHau/nix-portable";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # TODO: Install pkg
    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ssbm-nix.url =
      "github:lytedev/ssbm-nix"; # Fork of: "github:djanatyn/ssbm-nix";
    stylix.url = "github:danth/stylix";

    # --- Builders -------------------------------------------------
    kubenix.url = "github:hall/kubenix";
    jsonresume-nix = {
      url = "github:TaserudConsulting/jsonresume-nix";
      inputs.flake-utils.follows = "flake-utils";
    };

    # +-- Cachix --------------------------------------------------------------+
    # | devenv: flake-parts module to build TOML-based devenvs/devshells.      |
    # | pre-commit-hooks-nix: flake-parts module to define git precommit hooks |
    # +------------------------------------------------------------------------+
    devenv.url = "github:cachix/devenv";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";

    # +-- DeterminateSystems --------------------------------------------------+
    # | nuenv: Nushell Derivations                                             |
    # +------------------------------------------------------------------------+
    nix-installer = {
      url = "github:DeterminateSystems/nix-installer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuenv.url = "github:DeterminateSystems/nuenv";

    # +--- Divnix -------------------------------------------------------------+
    # | call-flake, dmerge, flops, yants, incl, nosys,                         |
    # | std, std-action, std-data-collection, hive                             |
    # +------------------------------------------------------------------------+
    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        devshell.follows = "devshell";
        makes.url = "github:fluidattacks/makes";
        n2c.url = "github:nlewo/nix2container";
        terranix.url = "github:terranix/terranix";
        arion = {
          url = "github:hercules-ci/arion";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        microvm = {
          url = "github:astro/microvm.nix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        nixago = {
          url = "github:nix-community/nixago";
          inputs = {
            nixpkgs.follows = "nixpkgs";
            nixago-exts = {
              url = "github:nix-community/nixago-extensions";
              inputs.nixpkgs.follows = "nixpkgs";
            };
          };
        };
      };
    };
    hive = {
      url = "github:divnix/hive";
      inputs = {
        colmena.url = "github:zhaofengli/colmena";
        nixago.inputs.nixago-exts.follows = "std/nixago/nixago-exts";
      };
    };
    call-flake.url = "github:divnix/call-flake";
    nosys.url = "github:divnix/nosys";
    quick-nix-registry.url = "github:divnix/quick-nix-registry";
    yants.url = "github:divnix/yants";

    # +-- edolstra ------------------------------------------------------------+
    # | flake-compat: flake compatibility layer for legacy Nix repos.          |
    # +------------------------------------------------------------------------+
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # +-- GTrunSec ------------------------------------------------------------+
    # | flops: Fork of divnix/flops                                            |
    # | hivebus:                                                               |
    # | omnibus:                                                               |
    # +------------------------------------------------------------------------+
    flops.url = "github:GTrunSec/flops";
    omnibus.url = "github:GTrunSec/omnibus";
    #hivebus = {
    #  url = "github:GTrunSec/hivebus";
    #  inputs.omnibus.follows = "omnibus";
    #};

    # +-- gytis-ivaskevicius --------------------------------------------------+
    # | flake-utils-plus: Utils for building flakes.                           |
    # +------------------------------------------------------------------------+
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-helm = {
      url = "github:gytis-ivaskevicius/nix-helm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # +-- gvolpe --------------------------------------------------------------+
    # | nmd:                                                                   |
    # +------------------------------------------------------------------------+
    nmd.url = "github:gvolpe/nmd";

    # +-- Hercules-CI ---------------------------------------------------------+
    # | flake-parts: Framework to build flake outputs using module system      |
    # | flake-parts-website: flake-parts module to build website               |
    # | hercules-ci-effects: flake-parts module to perform common CI tasks.    |
    # | hercules-ci-agent: nixos/hm modules to run agents for CI processes.    |
    # +------------------------------------------------------------------------+
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts-website.url = "github:hercules-ci/flake.parts-website";
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";

    # +-- Mic92 ---------------------------------------------------------------+
    # | envfs: filesystem for Nix store to fix some FHS stuff                  |
    # | fast-flake-update: Updates `flake.lock` faster than `nix flake update` |
    # +------------------------------------------------------------------------+
    envfs = {
      url = "github:Mic92/envfs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fast-flake-update.url = "github:Mic92/fast-flake-update";
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # +-- Numtide -------------------------------------------------------------+
    # | devshell: flake-parts module to build devshells.                       |
    # | flake-utils: Utils for building flakes.                                |
    # | system-manager: NixOS-like config for regular Linux distros.           |
    # | treefmt-nix: flake-parts module to build treefmt config.               |
    # +------------------------------------------------------------------------+
    devshell.url = "github:numtide/devshell";
    #devshell.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.flake-utils.follows = "flake-utils";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    #treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    # +-- Platonic-Systems ----------------------------------------------------+
    # | mission-control: flake-parts module for                                |
    # | process-compose-flake: flake-parts module for                          |
    # +------------------------------------------------------------------------+
    mission-control.url = "github:Platonic-Systems/mission-control";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";

    # +-- srid ----------------------------------------------------------------+
    # | emanote: flake-parts module for Markdown notes as HTML static site     |
    # | flake-check: packages.check: build all checks for current system       |
    # | flake-devour: Executable to devour flake & spit out outPath            |
    # | flake-root: flake-parts module to find flake's root dir                |
    # | haskell-flake: flake-parts module to                                   |
    # | nix-health: Show the health of your Nix system                         |
    # | nixid: flake-parts module to                                           |
    # | proc-flake: flake-parts module to                                      |
    # | nixos-flake:  https://github.com/srid/nixos-flake                      |
    # +------------------------------------------------------------------------+
    emanote.url = "github:srid/emanote";
    flake-root.url = "github:srid/flake-root";
    flake-check.url = "github:srid/check-flake";
    flake-devour = {
      url = "github:srid/devour-flake";
      flake = false;
    };
    haskell-flake.url = "github:srid/haskell-flake";
    nix-health.url = "github:srid/nix-health";
    nixid.url = "github:srid/nixid";
    proc-flake.url = "github:srid/proc-flake";

    # +-- Tweag ---------------------------------------------------------------+
    # | nixpkgs-graph-explorer: CLI to explore nixpkgs graph                   |
    # +------------------------------------------------------------------------+
    nixpkgs-graph-explorer.url = "github:tweag/nixpkgs-graph-explorer";

    # +-- vlinkz --------------------------------------------------------------+
    # | Developer of SnowflakeOS & its utils.                                  |
    # +------------------------------------------------------------------------+
    # | nix-software-center: GTK package manager for NixOS/SnowflakeOS.        |
    # | nixos-conf-editor:   GTK configuration UI for NixOS/SnowflakeOS.       |
    # +------------------------------------------------------------------------+
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";

    # --- SnowflakeOS ---------------------------------------------------------+
    # | GUI-oriented flavor of NixOS.                                          |
    # +------------------------------------------------------------------------+
    # | icicle: GTK installer for NixOS/SnowflakeOS                            |
    # | nix-data:                                                              |
    # | snow:                                                                  |
    # | snowflake:                                                             |
    # +------------------------------------------------------------------------+
    icicle.url = "github:snowflakelinux/icicle";
    nix-data.url = "github:snowflakelinux/nix-data";
    snow.url = "github:snowflakelinux/snow";
    snowflake.url = "github:snowflakelinux/snowflake-modules";

    # --- Extra Package Sets ---------------------------------------
    home-extra-xhmm.url = "github:schuelermine/xhmm";
    multifirefox.url = "git+https://codeberg.org/wolfangaukang/multifirefox";
    #nixpkgs-gnome.url = "github:NixOS/nixpkgs/gnome";
    nixpkgs-gnome-apps.url = "github:chuangzhu/nixpkgs-gnome-apps";
    nixpkgs-android.url = "github:tadfisher/android-nixpkgs";
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nixGL.url = "github:guibou/nixGL";
    nix-stable-diffusion = {
      url = "github:gbtb/nix-stable-diffusion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixified-ai = {
      url = "github:nixified-ai/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # --- Libs: Misc -----------------------------------------------
    # https://github.com/juspay/cachix-push
    dns = {
      url = "github:kirelagin/dns.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
