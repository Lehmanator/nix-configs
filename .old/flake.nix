{
outputs = { self, nixpkgs, nixos, home, nur, ... }@inputs: {
  nixosConfigurations.fw = with inputs; nixos.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit self inputs; user="sam";};
    modules = with inputs; [ ./hosts/fw
      nur.nixosModules.nur
      sops-nix.nixosModules.sops
      home.nixosModules.home-manager { home-manager = { sharedModules = [
          agenix.hmModules.default
          sops-nix.homeManagerModules.sops
        ];
        useGlobalPkgs = false;
        useUserPackages = true;
        extraSpecialArgs = {inherit self inputs; user="sam";};
        users.sam = import ./users/sam; # ./users/sam/home.nix
      };}
      agenix.nixosModules.default ({pkgs, lib, ... }: {environment.systemPackages=[inputs.agenix.packages.${pkgs.system}.default];})
      lanzaboote.nixosModules.lanzaboote
      disko.nixosModules.disko
    ];
  };
};

inputs = {
  # --- Main -----------------------------------------------------
  # https://discourse.nixos.org/t/differences-between-nix-channels/13998
  nixpkgs.url              = "github:NixOS/nixpkgs/nixos-unstable";
  nixpkgs-stable.url       = "github:NixOS/nixpkgs/release-23.05";
  nixpkgs-unstable.url     = "github:NixOS/nixpkgs/nixpkgs-unstable";
  nixpkgs-staging.url      = "github:NixOS/nixpkgs/staging";
  nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";
  nixpkgs-master.url       = "github:NixOS/nixpkgs/master";
  nixos.url                = "github:NixOS/nixpkgs/nixos-unstable";
  nixos-stable.url         = "github:NixOS/nixpkgs/nixos-23.05";
  nixos-unstable.url       = "github:NixOS/nixpkgs/nixos-unstable";
  home-manager.url         = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  impermanence.url = "github:nix-community/impermanence";
  disko.url = "github:nix-community/disko";
  disko.inputs.nixpkgs.follows = "nixpkgs";
  agenix.url = "github:ryantm/agenix";
  agenix.inputs.nixpkgs.follows = "nixpkgs";
  sops-nix.url = "github:Mic92/sops-nix";
  sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  lanzaboote.url = "github:nix-community/lanzaboote";
  lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

  nixos-hardware.url = "github:NixOS/nixos-hardware";

  # --- Image Builders: Nix --------------------------------------
  nixos-generators.url = "github:nix-community/nixos-generators";
  nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
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

  nixos-flatpak.url = "github:GermanBread/declarative-flatpak";
  nixos-flatpak.inputs.nixpkgs.follows = "nixpkgs";
  nixpak.url = "github:nixpak/nixpak";
  nixpak.inputs.nixpkgs.follows = "nixpkgs";

  # --- Packages: Pre-built Images -------------------------------
  nixos-images.url = "github:nix-community/nixos-images";
  devshell.url = "github:numtide/devshell";
  devshell.inputs.nixpkgs.follows = "nixpkgs";
  microvm.url = "github:astro/microvm.nix";
  microvm.inputs.nixpkgs.follows = "nixpkgs";
  colmena.url = "github:zhaofengli/colmena";
  colmena.inputs.nixpkgs.follows = "nixpkgs";
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

