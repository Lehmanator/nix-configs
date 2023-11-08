{
  nixConfig = {
    connect-timeout = 10;
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
    ];
    trusted-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = { self, nixpkgs, nixos, home, nur, ... }@inputs: {
    nixosConfigurations.fw = with inputs; nixos.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self inputs; system = "x86_64-linux"; user = "sam"; };
      modules = with inputs; [
        ./hosts/fw
        nix-data.nixosModules.nix-data
        nix-index.nixosModules.nix-index
        { programs.nix-index-database.comma.enable = true; }
        nur.nixosModules.nur
        agenix.nixosModules.default
        sops-nix.nixosModules.sops
        home.nixosModules.home-manager
        {
          home-manager = {
            sharedModules = [
              arkenfox.hmModules.default
              nix-index.hmModules.nix-index
              { programs.nix-index-database.comma.enable = true; }
              sops-nix.homeManagerModules.sops
            ];
            useGlobalPkgs = false;
            useUserPackages = true;
            extraSpecialArgs = { inherit self inputs; system = "x86_64-linux"; user = "sam"; };
            users.sam = import ./users/sam; # ./users/sam/home.nix
          };
        }
      ];
    };
  };

  inputs = {
    # --- Main -----------------------------------------------------
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    # --- System Types ---------------------------------------------
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable"; #/gnome";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
    home-extra-xhmm.url = "github:schuelermine/xhmm";
    system-manager.url = "github:numtide/system-manager";
    system-manager.inputs.flake-utils.follows = "flake-utils";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    # --- SnowflakeOS ----------------------------------------------
    snowflake.url = "github:snowflakelinux/snowflake-modules";
    snow.url = "github:snowflakelinux/snow";
    nix-data.url = "github:snowflakelinux/nix-data";
    # --- Image Builders: Nix --------------------------------------
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    # --- Image Builders: Non-Nix ----------------------------------
    # --- Extra Package Sets ---------------------------------------
    nixpkgs-gnome.url = "github:NixOS/nixpkgs/gnome";
    nixpkgs-gnome-mobile.url = "github:chuangzhu/nixpkgs-gnome-mobile";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-android.url = "github:tadfisher/android-nixpkgs";
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    flake-firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    nixGL.url = "github:guibou/nixGL";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nur.url = "github:nix-community/NUR";
    nix-stable-diffusion.url = "github:gbtb/nix-stable-diffusion";
    nix-stable-diffusion.inputs.nixpkgs.follows = "nixpkgs";
    nixified-ai.url = "github:nixified-ai/flake";
    nixified-ai.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-terraform-providers.url = "github:nix-community/nixpkgs-terraform-providers-bin";
    nixpkgs-terraform-providers.inputs.nixpkgs.follows = "nixpkgs";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # --- Libs: Organization ---------------------------------------
    # --- Libs: Packaging ------------------------------------------
    nixpak.url = "github:nixpak/nixpak";
    nixpak.inputs.nixpkgs.follows = "nixpkgs";
    # --- Libs: Flakes ---------------------------------------------
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-check.url = "github:srid/check-flake"; # check-flake: Adds a #check package for building all checks for the current system
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-devour = { url = "github:srid/devour-flake"; flake = false; }; # devour-flake: Executable to devour flake and spit out out paths
    # --- Libs: Misc -----------------------------------------------
    # https://github.com/juspay/cachix-push
    dns.url = "github:kirelagin/dns.nix";
    dns.inputs.nixpkgs.follows = "nixpkgs"; # (optionally) };
    # --- Modules: Flake-parts -------------------------------------
    # https://github.com/srid/nixos-flake
    flake-root.url = "github:srid/flake-root";
    nixid.url = "github:srid/nixid";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    # --- Modules: System ------------------------------------------
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    fprint-clear.url = "github:nixvital/fprint-clear";
    nixos-mobile = { url = "github:vlinkz/mobile-nixos/gnomelatest"; flake = false; }; #url = "github:NixOS/mobile-nixos";
    # --- Modules: Filesystems -------------------------------------
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    envfs.url = "github:Mic92/envfs";
    envfs.inputs.nixpkgs.follows = "nixpkgs";
    # --- Modules: Containers --------------------------------------
    nix-helm.url = "github:gytis-ivaskevicius/nix-helm";
    nix-helm.inputs.nixpkgs.follows = "nixpkgs";
    arion.url = "github:hercules-ci/arion";
    arion.inputs.nixpkgs.follows = "nixpkgs";
    # --- Modules: Secrets -----------------------------------------
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    scalpel.url = "github:polygon/scalpel";
    scalpel.inputs.nixpkgs.follows = "nixpkgs";
    # --- Modules: Servers -----------------------------------------
    # --- Modules: Configuration -----------------------------------
    stylix.url = "github:danth/stylix";
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
    arkenfox.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixos-flatpak.url = "github:GermanBread/declarative-flatpak";
    nixos-flatpak.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    # --- Packages: Pre-built Images -------------------------------
    nixos-images.url = "github:nix-community/nixos-images";
    # --- Packages: Package Management ------------------------------
    nur-update.url = "github:nix-community/nur-update"; # nur-update: Update NUR
    nix-quick-registry.url = "github:divnix/quick-nix-registry";
    nixpkgs-graph-explorer.url = "github:tweag/nixpkgs-graph-explorer"; # nixpkgs-graph-explorer: CLI to explore nixpkgs graph
    debnix.url = "github:ngi-nix/debnix";
    nurl = { url = "github:nix-community/nurl"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-init = { url = "github:nix-community/nix-init"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-melt = { url = "github:nix-community/nix-melt"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install package
    nvfetcher = { url = "github:berberman/nvfetcher"; inputs.nixpkgs.follows = "nixpkgs"; };
    patsh = { url = "github:nix-community/patsh"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    patchelf = { url = "github:NixOS/patchelf"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-portable = { url = "github:DavHau/nix-portable"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    nixdoc = { url = "github:nix-community/nixdoc"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    nix-index = { url = "github:Mic92/nix-index-database"; inputs.nixpkgs.follows = "nixpkgs"; };
    namaka = { url = "github:nix-community/namaka"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixago = { url = "github:nix-community/nixago"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Collect lib
    nixago-extensions = { url = "github:nix-community/nixago-extensions"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Collect lib
    # --- Packages: Nix --------------------------------------------
    # --- Nix Utils ------------------------------------------------
    nix-health.url = "github:srid/nix-health"; # nix-health: Show health of your Nix system
    kubenix.url = "github:hall/kubenix";
    fast-flake-update.url = "github:Mic92/fast-flake-update"; # Util to update `flake.lock` faster than `nix flake update`
    harmonia = { url = "github:nix-community/harmonia"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixt = { url = "github:nix-community/nixt"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-alien = { url = "github:thiagokokada/nix-alien"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-auto-changelog = { url = "github:loophp/nix-auto-changelog"; inputs.nixpkgs.follows = "nixpkgs"; };
    nuenv = { url = "github:DeterminateSystems/nuenv"; inputs.nixpkgs.follows = "nixpkgs"; };
    rnix-parser = { url = "github:nix-community/rnix-parser"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO: Install pkg
    napalm = { url = "github:nix-community/napalm"; inputs.nixpkgs.follows = "nixpkgs"; };
    naersk = { url = "github:nix-community/naersk"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-installer = { url = "github:DeterminateSystems/nix-installer"; inputs.nixpkgs.follows = "nixpkgs"; };
    # --- DevShells ------------------------------------------------
    nmd.url = "github:gvolpe/nmd";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
    # --- Packages: Individual Packages ----------------------------
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    icicle.url = "github:snowflakelinux/icicle";
    multifirefox.url = "git+https://codeberg.org/wolfangaukang/multifirefox";
  };


}

