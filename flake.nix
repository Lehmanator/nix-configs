{
  nixConfig = {
    connect-timeout = 10;
    #substituters = [
    #  "https://cache.nixos.org"
    #  "https://nixpkgs-wayland.cachix.org"
    #];
    #trusted-keys = [
    #  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    #];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    snowflake = { url = "github:snowflakelinux/snowflake-modules"; };
    snow = { url = "github:snowflakelinux/snow"; };
    nix-data = { url = "github:snowflakelinux/nix-data"; };
    nix-software-center = { url = "github:vlinkz/nix-software-center"; };
    nixos-conf-editor = { url = "github:vlinkz/nixos-conf-editor"; };
    icicle = { url = "github:snowflakelinux/icicle"; };
    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-images = { url = "github:nix-community/nixos-images"; };
    nixos-hardware = { url = "github:NixOS/nixos-hardware"; };
    #nixos-wsl           = { url = "github:NixOS/nixos-wsl";                                                };
    nix-on-droid = {
      # Termux, but using Nix
      # https://github.com/t184256/nix-on-droid-app
      # https://github.com/t184256/nix-compile-for-android
      # https://github.com/t184256/droidctl
      url = "github:t184256/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    liminix = { url = "https://gti.telent.net/dan/liminix"; flake = false; };
    robotnix = { url = "github:danielfullmer/robotnix"; inputs.nixpkgs.follows = "nixpkgs"; };
    #mobile              = { url = "github:NixOS/mobile-nixos";                              flake = false; };
    nixos-mobile = { url = "github:vlinkz/mobile-nixos/gnomelatest"; flake = false; };
    nixpkgs-gnome-mobile = { url = "github:chuangzhu/nixpkgs-gnome-mobile"; };
    nixpkgs-wayland = { url = "github:nix-community/nixpkgs-wayland"; };
    nixpkgs-terraform-providers = { url = "github:nix-community/nixpkgs-terraform-providers-bin"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixpkgs-android = { url = "github:tadfisher/android-nixpkgs"; };
    nixpkgs-mozilla = { url = "github:mozilla/nixpkgs-mozilla"; };
    flake-firefox-nightly.url = "github:colemickens/flake-firefox-nightly";
    nixGL = { url = "github:guibou/nixGL"; };
    nixified-ai = { url = "github:nixified-ai/flake"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-stable-diffusion = { url = "github:gbtb/nix-stable-diffusion"; inputs.nixpkgs.follows = "nixpkgs"; };

    nix-vscode-extensions = { url = "github:nix-community/nix-vscode-extensions"; };
    neovim-nightly-overlay = { url = "github:nix-community/neovim-nightly-overlay"; };
    fenix = { url = "github:nix-community/fenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };

    haumea = { url = "github:nix-community/haumea"; inputs.nixpkgs.follows = "nixpkgs"; };

    srvos = { url = "github:numtide/srvos"; };
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    home = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    darwin = { url = "github:LnL7/nix-darwin"; inputs.nixpkgs.follows = "nixpkgs"; };

    impermanence = { url = "github:nix-community/impermanence"; };

    nur = { url = "github:nix-community/NUR"; };
    nur-update = { url = "github:nix-community/nur-update"; };
    nurl = { url = "github:nix-community/nurl"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-init = { url = "github:nix-community/nix-init"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-melt = { url = "github:nix-community/nix-melt"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install inputs.nix-melt.packages.${system}.default
    nvfetcher = { url = "github:berberman/nvfetcher"; inputs.nixpkgs.follows = "nixpkgs"; };
    patsh = { url = "github:nix-community/patsh"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    patchelf = {
      url = "github:NixOS/patchelf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixago = { url = "github:nix-community/nixago"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Collect lib
    nixago-extensions = { url = "github:nix-community/nixago-extensions"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Collect lib


    std = { url = "github:divnix/std"; };
    hive = { url = "github:divnix/hive"; };
    fractal = { url = "github:divnix/fractal"; inputs.nixpkgs.follows = "nixpkgs"; };

    nix-helm = { url = "github:gytis-ivaskevicius/nix-helm"; inputs.nixpkgs.follows = "nixpkgs"; };
    arion = { url = "github:hercules-ci/arion"; inputs.nixpkgs.follows = "nixpkgs"; };

    nixvim = { url = "github:pta2002/nixvim"; inputs.nixpkgs.follows = "nixpkgs"; };


    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix = { url = "github:Mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    scalpel = { url = "github:polygon/scalpel"; inputs.nixpkgs.follows = "nixpkgs"; };


    nix-minecraft = { url = "github:Misterio77/nix-minecraft"; inputs.nixpkgs.follows = "nixpkgs"; };
    mineflake = { url = "github:nix-community/mineflake"; inputs.nixpkgs.follows = "nixpkgs"; };
    vscode-server = { url = "github:nix-community/nixos-vscode-server"; inputs.nixpkgs.follows = "nixpkgs"; };


    flake-utils = { url = "github:numtide/flake-utils"; };
    flake-utils-plus = { url = "github:gytis-ivaskevicius/flake-utils-plus"; };
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-parts = { url = "github:hercules-ci/flake-parts"; };


    nixt = { url = "github:nix-community/nixt"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-alien = { url = "github:thiagokokada/nix-alien"; inputs.nixpkgs.follows = "nixpkgs"; };

    arkenfox = { url = "github:dwarfmaster/arkenfox-nixos"; inputs.nixpkgs.follows = "nixpkgs"; };

    nuenv = { url = "github:DeterminateSystems/nuenv"; inputs.nixpkgs.follows = "nixpkgs"; };


    stylix.url = "github:danth/stylix";
    #nix-colors.url = "github:misterio77/nix-colors";
    nix-portable = { url = "github:DavHau/nix-portable"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    nixdoc = { url = "github:nix-community/nixdoc"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    namaka = { url = "github:nix-community/namaka"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    rnix-parser = { url = "github:nix-community/rnix-parser"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    harmonia = { url = "github:nix-community/harmonia"; inputs.nixpkgs.follows = "nixpkgs"; };
    comma = { url = "github:nix-community/comma"; inputs.nixpkgs.follows = "nixpkgs"; };

    napalm = { url = "github:nix-community/napalm"; inputs.nixpkgs.follows = "nixpkgs"; };
    naersk = { url = "github:nix-community/naersk"; inputs.nixpkgs.follows = "nixpkgs"; };
    #rust-overlay = {
    #  url = "github:oxalica/rust-overlay";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #  inputs.flake-utils.follows = "flake-utils";
    #};

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      #inputs.rust-overlay.follows = "rust-overlay";
    };

    # saschagrunert/kubernix
    kubenix = { url = "github:hall/kubenix"; };
    nix-policy = { url = "github:DeterminateSystems/nix-policy"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-installer = { url = "github:DeterminateSystems/nix-installer"; inputs.nixpkgs.follows = "nixpkgs"; };
    vaultModule = {
      url = "github:DeterminateSystems/nixos-vault-service/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    asset-tagger = {
      # Print asset tags
      url = "github:DeterminateSystems/asset-tagger";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scanoss-nix = {
      # Scan OSS packages for vulns, misconfigs, etc.
      url = "github:DeterminateSystems/scanoss-nix";
      flake = false;
    };
    nix-netboot-serve = {
      # Serve NixOS configs as Netboot images
      url = "github:DeterminateSystems/nix-netboot-serve";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      # Nix code formatters
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vault-credential-yubikey.url = "github:grahamc/vault-credential-yubikey";
    vault-plugin-secrets-github.url = "github:martinbaillie/vault-plugin-secrets-github";
    systemd-vaultd = {
      # Provide systemd services w/ Hashicorp Vault secret access
      url = "github:numtide/systemd-vaultd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jupyenv.url = "github:tweag/jupyenv";
    #nixpkgs-graph.url = "github:tweag/nixpkgs-graph";
    nixpkgs-graph-explorer.url = "github:tweag/nixpkgs-graph-explorer";


    devshell = {
      # Developer shells
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    envfs = {
      # FUSE fs that returns symlinks to executables
      url = "github:Mic92/envfs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tex2nix = {
      # Generate Texlive environment containing all document deps
      url = "github:Mic92/tex2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-serve-ng = {
      # Faster drop-in replacement for nix-serve
      url = "github:aristanetworks/nix-serve-ng";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #selfhostblocks = {
    #  url = "github:ibizaman/selfhostblocks";
    #  flake = false;
    #};
    #coricamu.url = "github:danth/coricamu"; @  # Static site generator

    microvm = {
      # Spin up lightweight VMs from your configurations
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Module Documentation generator
    nmd.url = "github:gvolpe/nmd";
    musnix = { url = "github:musnix/musnix"; };
    colmena = { url = "github:zhaofengli/colmena"; inputs.nixpkgs.follows = "nixpkgs"; };



    firefly = { url = "github:timhae/firefly"; inputs.nixpkgs.follows = "nixpkgs"; };
    #nixos-mailserver = { url = "gitlab:lewo/nixos-mailserver"; };
    #nixcloud = { url = "github:nixcloud/nixcloud-webservices"; };
    lldap = {
      url = "github:NickCao/lldap";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        #rust-overlay.follows = "rust-overlay";
      };
    };


    flatpaks = {
      # declarative-flatpaks: Declaratively manage flatpaks
      url = "github:GermanBread/declarative-flatpak"; # - Modules for NixOS & HomeManager
      inputs.nixpkgs.follows = "nixpkgs"; #
    }; #
    nixpak = {
      # nixpak: Flatpak sandboxing for Nix packages
      url = "github:nixpak/nixpak"; # - nixpak.lib.nixpak
      inputs.nixpkgs.follows = "nixpkgs"; #
    }; #

  };
  outputs = { self, nixpkgs, nur, flake-utils, flake-utils-plus, ... }@inputs:
    let

      this = import ./pkgs;

      #flake-utils.lib.eachDefaultSystem (system:
      #  let pkgs = nixpkgs.legacyPackages.${system}; in {
      #    nurpkgs = import nixpkgs { inherit system; };
      #  }
      #)

      #supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      #forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (s: f s);
      system = "x86_64-linux";
      #networks = import ./networks.nix;
      #machines = import ./machines.nix;
      #users = import ./users.nix;

      defaults = with inputs; {
        modules = {
          #installer = with nixos-images.nixosModules; [ noninteractive kexec-installer netboot-installer ];
          nixos = [
            agenix.nixosModules.default
            arion.nixosModules.arion
            disko.nixosModules.disko
            flatpaks.nixosModules.default
            harmonia.nixosModules.harmonia
            impermanence.nixosModules.impermanence
            lanzaboote.nixosModules.lanzaboote
            musnix.nixosModules.musnix
            #nix-data.nixosModules.${system}.nix-data
            nix-minecraft.nixosModules.minecraft-servers
            nix-netboot-serve.nixosModules.nix-netboot-serve
            nix-serve-ng.nixosModules.default
            nixvim.nixosModules.nixvim
            nur.nixosModules.nur
            robotnix.nixosModule
            robotnix.nixosModules.attestation-server
            snowflake.nixosModules.snowflake
            scalpel.nixosModule
            sops-nix.nixosModules.sops
            #stylix.nixosModules.stylix
            systemd-vaultd.nixosModules.vaultAgent
            systemd-vaultd.nixosModules.systemdVaultd
            vaultModule.nixosModule
            vscode-server.nixosModule
          ];
          darwin = [
            agenix.nixDarwinModules.default
            home.darwinModule
            nixvim.nixDarwinModules.default
            #stylix.darwinModules.stylix
          ];
          hm = [
            agenix.homeManagerModules.default
            arkenfox.hmModules.default
            flatpaks.homeManagerModules.default
            nixpkgs-android.hmModule
            nixvim.homeManagerModules.nixvim
            sops-nix.homeManagerModules.sops
            #stylix.homeManagerModules.stylix
          ];
          system = [ ];
          nix-on-droid = [ ];
          wsl = [ ];
          nix = [ ];
          flake-parts = [
            devshell.flakeModule
            treefmt-nix.flakeModule
          ];
        };
        overlays = {
          nixos = [
            nix-minecraft.overlay
          ];
          darwin = [
          ];
          hm = [
          ];
          nix = [
            self.overlays.default
            agenix.overlays.default
            fenix.overlays.default
            harmonia.overlays
            lanzaboote.overlays.default
            mineflake.overlays.default
            neovim-nightly-overlay.overlay
            nix-vscode-extensions.overlays.default
            nixgl.overlay
            nixpkgs-mozilla.overlay
            nixpkgs-terraform-providers.overlay
            nixpkgs-wayland.overlay
            nmd.overlays.default
            nuenv.overlays.default
            nur.overlay
            nurl.overlay
            patchelf.overlays.default
            rnix-parser.overlay
            #terrasops.overlay
          ];
        };
      };
    in
    #flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ]A (system:
      #let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ];};)
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system} // {
          overlays = [
            self.overlays.default
            inputs.nixpkgs-mozilla.overlay
            inputs.nuenv.overlays.default # https://determinate.systems/posts/nuenv
            inputs.nur.overlay
            inputs.nurl.overlay
            inputs.nix-alien.overlays.default
            #inputs.terrasops.overlay
          ];
        };
        in
        rec {
          packages = this.packages pkgs; # // { inherit (pkgs) terrasops; };
          legacyPackages = pkgs;
          devShells.default = with pkgs; mkShell {
            nativeBuildInputs = [
              colmena
              mdbook
              #terrasops
              nvfetcher
            ];
          };
          #formatter = pkgs.nixpkgs-fmt;
          formatter = inputs.treefmt-nix.lib.mkWrapper pkgs {
            projectRootFile = "flake.nix";
            programs.nixpkgs-fmt.enable = true;
            #programs.alejandra.enable = true;
          };
        }
      ) // {
      overlays.default = final: prev: (nixpkgs.lib.composeExtensions this.overlay final prev);

      #darwinConfigurations."m2" = nixpkgs.lib.darwinSystem {
      #  system = "aarch64-darwin";
      #
      #  modules = defaults.modules.darwin ++ [
      #    ./hosts/m2
      #    home.darwinModule {
      #      home-manager = {
      #        extraSpecialArgs = { inherit self inputs system; };
      #        sharedModules = defaults.modules.hm ++ self.homeManagerModules ++ ./users/common;
      #        useGlobalPkgs = true;
      #        useUserPackages = true;
      #        users = {
      #          guest = import ./users/guest/home.nix;
      #          main  = import ./users/main/home.nix;
      #        };
      #      };
      #    }
      #  ];
      #};

      nixosConfigurations."fw" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = with inputs; [
          ./hosts/fw/configuration.nix
          snowflake.nixosModules.snowflake
          nix-data.nixosModules.${system}.nix-data
          nixos-hardware.nixosModules.framework-12th-gen-intel
          nixvim.nixosModules.nixvim
          nur.nixosModules.nur
          agenix.nixosModules.default
          sops-nix.nixosModules.sops
          home.nixosModules.home-manager
          {
            home-manager = {
              #(import ./profiles/home-manager.nix { inherit self inputs system; users.sam = (import ./users/sam {}); });
              sharedModules = [
                #impermanence.nixosModules.home-manager
                #(import ./users/default/nixos {};)
                arkenfox.hmModules.default
                nixpkgs-android.hmModule
                sops-nix.homeManagerModules.sops
              ];
              useGlobalPkgs = false;
              useUserPackages = true;
              extraSpecialArgs = { inherit self inputs system; };
              users.sam = import ./users/sam; # ./users/sam/home.nix
            };
          }
        ];
        specialArgs = { inherit self inputs system; };
      };

      nixosConfigurations.fajita = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          (import "${inputs.nixos-mobile}/lib/configuration.nix" { device = "oneplus-fajita"; })
          ./hosts/fajita/configuration.nix
          inputs.snowflake.nixosModules.snowflake
          inputs.nix-data.nixosModules."aarch64-linux".nix-data
          inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
        ];
        specialArgs = { inherit self inputs system; };
      };
      fajita-fastboot-images = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-fastboot-images;
      fajita-flashable-zip = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-flashable-zip;

      #homeConfigurations.sam = inputs.home.lib.homeManagerConfiguration {
      #  inherit pkgs;
      #  modules = [
      #    ./users/sam   #./users/sam/home.nix
      #  ];
      #};


      #modules = flake-utils.lib.eachDefaultSystem (system: let
      #  inherit inputs;
      #  nurpkgs = import nixpkgs {inherit system;};
      #in [
      # NUR repos via package overrides
      #{ nixpkgs.config.packageOverrides = pkgs: {
      #  inherit inputs system;
      #  nur = import inputs.nur {
      #    inherit pkgs nurpkgs;
      #    repoOverrides = {
      #      #local     = import inputs.nur-local { inherit pkgs; };
      #      #publicSam = import inputs.nur-repo { inherit pkgs; };
      #    };
      #  }; };
      #}
      # NUR repos via overlays
      #{ nixpkgs.overlays = let pkgs = nixpkgs.legacyPackages.${system}; in [ (final: prev: {
      #  inherit inputs system pkgs;
      #  #pkgs = import nixpkgs {inherit system;};
      #  nur = import inputs.nur {
      #    inherit pkgs nurpkgs;
      #    repoOverrides = {
      #      #local    = import inputs.nur-local { inherit pkgs; };
      #      #publicSam = import inputs.nur-repo { inherit pkgs; };
      #    };
      #  };
      #})];
      #}
      #]); # --- End: outputs.modules ---
      apps.nextcloud-next26 = let helmish = inputs.nix-helm.deployments; in
        helmish: {
          nextcloud = import ./helm/nextcloud.nix { inherit helmish; };
        };
    }; # --- End: outputs ---

}

