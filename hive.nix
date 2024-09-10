{
  outputs = { self, std, hive, nixpkgs, nixos, home, nur, ... } @ inputs: hive.growOn
    {
      inherit inputs;
      nixpkgsConfig = {
        allowUnfree = true;
      };
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; with hive.blockTypes; [
        # modules implement
        (functions "nixosModules")
        (functions "homeModules")
        (functions "devshellModules")
        # profiles activate
        (functions "hardwareProfiles")
        (functions "nixosProfiles")
        (functions "homeProfiles")
        (functions "devshellProfiles")
        (functions "diskoProfiles")
        (functions "nixvimProfiles")
        # suites aggregate profiles
        (functions "nixosSuites")
        (functions "homeSuites")
        # configurations can be deployed
        nixosConfigurations
        colmenaConfigurations
        homeConfigurations
        diskoConfigurations
        hardwareConfigurations
        # devshells can be entered
        (devshells "shells")
        # installables
        packages
        (functions "overlays")
        # Libs
        (functions "libs")
      ];
    }
    {
      # soil
      devShells = std.harvest self [ "repo" "shells" ];
      overlays = std.harvest self [ "repo" "overlays" ];
      packages = std.harvest self [ "repo" "packages" ];
      lib = std.harvest self [ "repo" "libs" ];
    }
    {
      colmenaHive = hive.collect self "colmenaConfigurations";
      nixosConfigurations = hive.collect self "nixosConfigurations";
      homeConfigurations = hive.collect self "homeConfigurations";
      diskoConfigurations = hive.collect self "diskoConfigurations";
      hardwareConfigurations = hive.collect self "hardwareConfigurations";
    };

  inputs = {
    std.url = "github:divnix/std";
    std.inputs.devshell.follows = "devshell";
    std.inputs.nixago.follows = "nixago";
    std.inputs.nixpkgs.follows = "nixpkgs";

    hive.url = "github:divnix/hive";
    hive.inputs.colmena.follows = "colmena";
    hive.inputs.disko.follows = "disko";
    hive.inputs.nixos-generators.follows = "nixos-generators";
    hive.inputs.nixpkgs.follows = "nixpkgs";

    #colmena.url = "github:blaggacao/colmena/fix-1000-nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
    colmena.inputs.stable.follows = "std/blank";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    nixago.inputs.nixago-exts.follows = "";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.inputs.nixlib.follows = "nixpkgs";

    home.follows = "home-unstable";
    home-unstable.url = "github:nix-community/home-manager";
    home-23-05.url = "github:nix-community/home-manager/release-23.05";

    nixos.follows = "nixos-unstable";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-23-05.url = "github:NixOS/nixpkgs/release-23.05";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    qnr.url = "github:divnix/quick-nix-registry";

    # --- Main -----------------------------------------------------
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    #nixos.url                = "github:NixOS/nixpkgs/nixos-unstable";
    #nixos-unstable.url       = "github:NixOS/nixpkgs/nixos-unstable";

    impermanence.url = "github:nix-community/impermanence";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # --- Image Builders: Nix --------------------------------------
    flake-firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nur.url = "github:nix-community/NUR";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # --- Libs: Flakes ---------------------------------------------
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-check.url = "github:srid/check-flake"; # check-flake: Adds a #check package for building all checks for the current system
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-devour = { url = "github:srid/devour-flake"; flake = false; }; # devour-flake: Executable to devour flake and spit out out paths

    # --- Modules: System ------------------------------------------
    fprint-clear.url = "github:nixvital/fprint-clear";
    nixos-mobile = { url = "github:vlinkz/mobile-nixos/gnomelatest"; flake = false; }; #url = "github:NixOS/mobile-nixos";

    # --- Modules: Filesystems -------------------------------------
    envfs.url = "github:Mic92/envfs";
    envfs.inputs.nixpkgs.follows = "nixpkgs";

    # --- Modules: Containers --------------------------------------
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmoderna/nix-flatpak";
    nixpak.url = "github:nixpak/nixpak";
    nixpak.inputs.nixpkgs.follows = "nixpkgs";

    # --- Modules: Home-Manager ------------------------------------
    ssbm-nix.url = "github:djanatyn/ssbm-nix";

    # --- Packages: Pre-built Images -------------------------------
    nixos-images.url = "github:nix-community/nixos-images";
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    connect-timeout = 10;
    extra-substituters = [
      #"https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
      "https://numtide.cachix.org/"
    ];
    extra-trusted-public-keys = [
      #"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };

}

