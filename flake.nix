{
  description = "Personal Nix & NixOS configurations";
  outputs = { self, nixpkgs, nixos, home, nur, flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs self;} {
      imports = [./parts];
      debug = true;
      systems = ["x86_64-linux" "aarch64-linux" "riscv64-linux"];
      perSystem = { config, lib, pkgs, system, final, ... }: {
        packages = {
          inherit (inputs.disko.packages.${system}) disko disko-doc;
        };
      };
      flake = {
        inherit inputs self;
        overlays = import ./nixos/overlays;
        nixosConfigurations.fw = nixos.lib.nixosSystem {
          modules = [./nixos/hosts/fw];
          specialArgs = { inherit inputs; user = "sam"; };
        };
        # nixosConfigurations = let
        #   mkSystem = import ./lib/flake/mkSystem.nix { inherit inputs self; hostsDir = ./nixos/hosts; };
        #   mkSystems = builtins.mapAttrs (n: v: mkSystem ({ host = n; } // v));
        # in mkSystems {
        #   fw             = { device = "laptop"; };
        #   wyse           = {};
        #   # fajita         = { mobile = true; device="oneplus-fajita"; system="aarch64-linux"; };
        #   # fajita-minimal = { mobile = true; device="oneplus-fajita"; };
        # };
      };
    };

  nixConfig = {
    extra-substituters = [ "https://lehmanator.cachix.org/" ];
    extra-trusted-public-keys = [ "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU=" ];
  };

  inputs = {
    # --- Main -----------------------------------------------------
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # --- Nixpkgs -----------------------------------------------------
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows          = "nixpkgs-stable";
    nixpkgs-stable.url       = "github:NixOS/nixpkgs/release-24.11";
    nixpkgs-unstable.url     = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-staging.url      = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";
    nixpkgs-master.url       = "github:NixOS/nixpkgs/master";
    nixpkgs-darwin.url       = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    stable.follows           = "nixpkgs-stable";
    unstable.follows         = "nixpkgs-unstable";
    # --- System Types ---------------------------------------------
    nixos.follows            = "nixos-stable";
    nixos-stable.url         = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-unstable.url       = "github:NixOS/nixpkgs/nixos-unstable";
    system-manager      = {inputs.nixpkgs.follows="nixos";   url="github:numtide/system-manager";};
    wrapper-manager     = {inputs.nixpkgs.follows="nixos";   url="github:viperML/wrapper-manager";};
    darwin              = {inputs.nixpkgs.follows="nixos";   url="github:lnl7/nix-darwin";};
    home                = {inputs.nixpkgs.follows="nixos";   url="github:nix-community/home-manager/release-24.11";};
    home-extra-xhmm.url = "github:schuelermine/xhmm";

    # --- SnowflakeOS ----------------------------------------------
    snowfall-lib        = {inputs.nixpkgs.follows="nixpkgs"; url="github:snowfallorg/lib";     }; # xtras: flake-utils-plus, flake-compat
    snowflake-os        = {url="github:snowfallorg/snowflakeos-modules"; inputs={nixpkgs.follows="nixpkgs"; snowfall-lib.follows="snowfall-lib";};}; # xtras: nix-software-center, nixos-conf-editor, snow, snowflake-os-module-manager snowfall-lib
    snowfall-flake      = {url="github:snowfallorg/flake"; inputs={
      nixpkgs.follows="nixpkgs";
      snowfall-lib.follows="snowfall-lib";
      flake-compat.follows="flake-compat";
    };};
    nix-data            = {inputs={nixpkgs.follows="nixpkgs"; snowfall-lib.follows="snowfall-lib";}; url="github:snowfallorg/nix-data";};
    icicle              = {inputs={nixpkgs.follows="nixpkgs"; snowfall-lib.follows="snowfall-lib";}; url="github:snowfallorg/icicle";           };

    # --- Image Builders: Nix --------------------------------------
    nixos-generators    = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixos-generators";}; # xtra-inputs: nixlib
    # --- Image Builders: Non-Nix ----------------------------------
    # --- Mobile ---------------------------------------------------
    nixpkgs-gnome-mobile.url = "github:Lehmanator/nixpkgs-gnome-mobile/develop";
    nixos-mobile        = {flake=false; url="github:vlinkz/mobile-nixos/gnomelatest";}; # url = "github:NixOS/mobile-nixos";
    mobile-nixos        = {flake=false; url="github:lehmanator/mobile-nixos/update-firmware";};
    #mobile-nixos = {flake=false; url="github:NixOS/mobile-nixos/development";};
    # --- Extra Package Sets ---------------------------------------
    #nixpkgs-gnome.url = "github:NixOS/nixpkgs/gnome";
    nixpkgs-gnome-apps.url = "github:chuangzhu/nixpkgs-gnome-apps";
    nixpkgs-android       = {inputs.nixpkgs.follows="nixpkgs"; url="github:tadfisher/android-nixpkgs";}; #xtra: devshell,flake-utils
    nixpkgs-wayland       = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixpkgs-wayland";}; #xtra: lib-aggregate,nix-eval-jobs,flake-compat
    firefox               = {
      #inputs.nixpkgs.follows="nixpkgs";
       url="github:nix-community/flake-firefox-nightly";}; #xtra: lib-aggregate, cachix, mozilla, flake-compat
    nixGL                 = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixGL";}; #xtra: flake-utils
    nur                   = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/NUR";}; # xtra: flake-parts, treefmt-nix
    neovim                = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/neovim-nightly-overlay";}; #xtra: flake-parts, hercules-ci-effects, flake-compat, git-hooks, treefmt-nix
    nix-vscode-extensions = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nix-vscode-extensions";};
    nix-stable-diffusion  = {inputs.nixpkgs.follows="nixpkgs"; url="github:gbtb/nix-stable-diffusion";};
    tf-providers          = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixpkgs-terraform-providers-bin";};
    nixified-ai           = {inputs.nixpkgs.follows="nixpkgs"; url="github:nixified-ai/flake";};
    fenix                 = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/fenix";};
    rust-overlay          = {inputs.nixpkgs.follows="nixpkgs"; url="github:oxalica/rust-overlay";};
    # --- Libs: Organization ---------------------------------------
    std.url     = "github:divnix/std";
    hive.url    = "github:divnix/hive";
    omnibus.url = "github:GTrunSec/omnibus";

    # --- Libs: Packaging ------------------------------------------
    nixpak = {inputs.nixpkgs.follows="nixpkgs"; url="github:nixpak/nixpak";};
    # --- Libs: Flakes ---------------------------------------------
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus = {url="github:gytis-ivaskevicius/flake-utils-plus"; inputs.flake-utils.follows="flake-utils";};
    flake-compat = {flake=false; url="github:edolstra/flake-compat";};

    # --- Libs: Misc -----------------------------------------------
    # https://github.com/juspay/cachix-push
    dns            = {inputs.nixpkgs.follows="nixpkgs"; url="github:kirelagin/dns.nix";};
    github-actions = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nix-github-actions";};

    # --- Modules: Flake-parts -------------------------------------
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix-shell = {
      url = "github:aciceri/agenix-shell";
      inputs = { nixpkgs.follows="nixpkgs"; flake-parts.follows="flake-parts"; };
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs = { nixpkgs.follows="nixpkgs"; devshell.follows="devshell"; flake-parts.follows="flake-parts"; pre-commit-hooks.follows="pre-commit-hooks"; treefmt-nix.follows="treefmt"; };
    };

    # https://github.com/srid/nixos-flake
    flake-check.url = "github:srid/check-flake"; # flakeModule: Package `#check` to build all checks for curr system
    flake-root.url  = "github:srid/flake-root";  # flakeModule: Find flake project root dir
    nixid.url       = "github:srid/nixid";       # flakeModule: Nix edit->save->eval loop in `outputs.apps.default` 
    proc-flake.url  = "github:srid/proc-flake";  # flakeModule: Running multiple processes in a dev shell

    # https://github.com/srid/emanote - flakeModule: Note webserver from plaintext notes w/ linking, tags, & more
    #xtra: flake-parts,haskell-flake,treefmt-nix,flake-root,nixos-unified,ema,heist-extra,unionmount,commonmark-simple,commonmark-wikilink,emanote-template
    emanote      = {inputs.nixpkgs.follows="nixpkgs"; url="github:srid/emanote"; }; 

    # https://github.com/srid/nix-health
    # Determine Nix system health #xtra: flake-parts,nuenv
    nix-health   = {inputs.nixpkgs.follows="nixpkgs"; url="github:srid/nix-health";}; 

    # https://github.com/srid/devour-flake
    # Consumer flake to depend on all outputs of a given flake, building all its packages
    # flake-devour = {inputs.nixpkgs.follows="nixpkgs"; url="github:srid/devour-flake";}; 

    devshell    = {inputs.nixpkgs.follows="nixpkgs"; url="github:numtide/devshell";};
    treefmt     = {inputs.nixpkgs.follows="nixpkgs"; url="github:numtide/treefmt-nix";};

    devenv      = {inputs.nixpkgs.follows="nixpkgs"; url="github:cachix/devenv";};
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "unstable";
        nixpkgs-stable.follows = "stable";
        flake-compat.follows = "flake-compat";
        gitignore.follows = "gitignore";
      };
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "unstable";
        nixpkgs-stable.follows = "stable";
        flake-compat.follows = "flake-compat";
        gitignore.follows = "gitignore";
      };
    };

    gitignore.url = "github:hercules-ci/gitignore.nix";
    hercules-ci-effects = {inputs.nixpkgs.follows="nixpkgs"; url="github:hercules-ci/hercules-ci-effects";}; #xtra: flake-parts
    hercules-ci-agent   = {inputs.nixpkgs.follows="nixpkgs"; url="github:hercules-ci/hercules-ci-agent";  }; #xtra: flake-parts

    nix-cargo-integration = {
      url = "github:yusdacra/nix-cargo-integration";
      inputs = {nixpkgs.follows="nixpkgs"; parts.follows="flake-parts"; treefmt.follows="treefmt"; }; 
    }; # crane, dream2nix, mk-naked-shell
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";

    # --- Modules: System ------------------------------------------
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    fprint-clear.url = "github:Lehmanator/fprint-clear";

    srvos = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/srvos";};
    # --- Modules: Filesystems -------------------------------------
    impermanence.url = "github:nix-community/impermanence";
    disko    = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/disko";};
    envfs    = {inputs.nixpkgs.follows="nixpkgs"; url="github:Mic92/envfs";};
    # --- Modules: Containers --------------------------------------
    nix-helm = {inputs.nixpkgs.follows="nixpkgs"; url="github:gytis-ivaskevicius/nix-helm";};
    arion    = {inputs.nixpkgs.follows="nixpkgs"; url="github:hercules-ci/arion";}; #xtra: flake-parts,haskell-flake
    # --- Modules: Secrets -----------------------------------------
    agenix   = {inputs.nixpkgs.follows="nixpkgs"; url="github:ryantm/agenix";};
    sops-nix = {inputs.nixpkgs.follows="nixpkgs"; url="github:Mic92/sops-nix";};
    # scalpel = {inputs.nixpkgs.follows="nixpkgs"; url = "github:polygon/scalpel";};
    # --- Modules: Servers -----------------------------------------
    # --- Modules: Configuration -----------------------------------
    stylix     = {
      url = "github:danth/stylix";
      inputs = { nixpkgs.follows="nixpkgs"; home-manager.follows="home"; flake-utils.follows="flake-utils"; flake-compat.follows="flake-compat"; };
    };
    arkenfox   = {inputs.nixpkgs.follows="nixpkgs"; url="github:dwarfmaster/arkenfox-nixos";};
    lanzaboote = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/lanzaboote";};
    nixvim     = {inputs.nixpkgs.follows="nixos";   url="github:nix-community/nixvim";};
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    slippi = { 
      url = "github:lytedev/slippi-nix";
      inputs = {nixpkgs.follows="nixpkgs"; home-manager.follows="home"; git-hooks.follows="git-hooks";};
    };
    # --- Packages: Pre-built Images -------------------------------
    nixos-images.url = "github:nix-community/nixos-images";
    # --- Packages: Package Management ------------------------------
    quick-nix-registry.url = "github:divnix/quick-nix-registry";
    nixpkgs-graph-explorer.url = "github:tweag/nixpkgs-graph-explorer"; # nixpkgs-graph-explorer: CLI to explore nixpkgs graph
    debnix = {  # Translate package names Nix <-> Debian
      url = "github:ngi-nix/debnix";
      inputs = {nixpkgs.follows="nixpkgs"; rust-overlay.follows="rust-overlay"; flake-utils.follows="flake-utils"; flake-compat.follows="flake-compat"; }; #crate2nix.follows="crate2nix"; };
    };
    nur-update        = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nur-update";}; # nur-update: Update NUR
    nurl              = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nurl";};
    nix-init          = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nix-init";};
    nix-melt          = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nix-melt";}; # TODO: Install package
    patsh             = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/patsh";}; # TODO: Install pkg
    patchelf          = {inputs.nixpkgs.follows="nixpkgs"; url="github:NixOS/patchelf";};
    nix-portable      = {inputs.nixpkgs.follows="nixpkgs"; url="github:DavHau/nix-portable";}; # TODO: Install pkg
    nixdoc            = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixdoc";}; # TODO: Install pkg
    nix-index         = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nix-index-database";};
    nix-fast-build    = {inputs.nixpkgs.follows="nixpkgs"; url="github:Mic92/nix-fast-build";};
    namaka            = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/namaka";};
    nixago            = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixago";}; # TODO: Collect lib
    nixago-extensions = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixago-extensions";}; # TODO: Collect lib
    # --- Packages: Nix --------------------------------------------
    # --- Nix Utils ------------------------------------------------
    kubenix.url = "github:hall/kubenix";
    fast-flake-update.url = "github:Mic92/fast-flake-update"; # Util to update `flake.lock` faster than `nix flake update`
    harmonia      = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/harmonia";};
    nixt          = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/nixt";};
    nix-alien     = {inputs.nixpkgs.follows="nixpkgs"; url="github:thiagokokada/nix-alien";};
    nix-auto-changelog = {inputs.nixpkgs.follows="nixpkgs"; url="github:loophp/nix-auto-changelog";};
    nuenv         = {inputs.nixpkgs.follows="nixpkgs"; url="github:DeterminateSystems/nuenv";};
    rnix-parser   = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/rnix-parser";}; # TODO: Install pkg
    napalm        = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/napalm";};
    naersk        = {inputs.nixpkgs.follows="nixpkgs"; url="github:nix-community/naersk";};
    nix-installer = {inputs.nixpkgs.follows="nixpkgs"; url="github:DeterminateSystems/nix-installer";};
    # --- Builders -------------------------------------------------
    jsonresume-nix = {
      inputs.flake-utils.follows = "flake-utils";
      url = "github:TaserudConsulting/jsonresume-nix";
    };
    # --- DevShells ------------------------------------------------
    nmd.url = "github:gvolpe/nmd";
    microvm = {inputs.nixpkgs.follows="nixpkgs"; url="github:astro/microvm.nix";};
    colmena = {inputs.nixpkgs.follows="nixpkgs"; url="github:zhaofengli/colmena";};
    # --- Packages: Individual Packages ----------------------------
    multifirefox.url = "git+https://codeberg.org/wolfangaukang/multifirefox";
  };
}
