rec {
  # --- Nixpkgs ----------------------------------
  nixos-unstable = {
    url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  nixos-stable = {
    url = "github:NixOS/nixpkgs/nixos-22.11";
  };
  nixos-prev = {
    url = "github/NixOS/nixpkgs/nixos-22.11";
  };
  nixos-next = {
    url = "github/NixOS/nixpkgs/nixos-23.05";
  };
  nixos = nixos-unstable;
  nixpkgs = nixos;

  nixpkgs-master = {
    url = "github:NixOS/nixpkgs/master";
  };
  #nixpkgs = {
  #  url = "github:NixOS/nixpkgs/nixos-unstable";
  #};

  # --- SnowflakeOS ------------------------------
  snowflake = {
    url = "github:snowflakelinux/snowflake-modules";
  };
  nix-data = {
    url = "github:snowflakelinux/nix-data";
  };
  nix-software-center = {
    url = "github:vlinkz/nix-software-center";
  };
  nixos-conf-editor = {
    url = "github:vlinkz/nixos-conf-editor";
  };
  snow = {
    url = "github:snowflakelinux/snow";
  };
  icicle = {
    url = "github:snowflakelinux/icicle";
  };

  # --- Systems ----------------------------------
  nixos-wsl = {
    url = "github:nix-community/NixOS-WSL";
  };
  robotnix = {
    url = "github:danielfullmer/robotnix";
  };

  # --- Packaging --------------------------------
  dream2nix = {
    url = "github:nix-community/dream2nix";
  };

  # --- Extra Packages ---------------------------
  nur = {
    url = "github:nix-community/NUR";
  };
  android-nixpkgs = {
    url = "github:tadfisher/android-nixpkgs";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  nvfetcher = {
    url = "github:berberman/nvfetcher";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  rust-overlay = {
    url = "github:oxalica/rust-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };
  fenix = {
    url = "github:nix-community/fenix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  firefox-addons = {
    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  dreampkgs = {
    url = "github:nix-community/dreampkgs";
  };

  # --- Libs -------------------------------------
  hive = {
    url = "github:divnix/hive";
  };
  haumea = {
    url = "github:nix-community/haumea";
  };

  # --- Secrets ----------------------------------
  agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.nixpkgs-stable.follows = "nixpkgs-stable";
  };

  # --- Flake Utilities --------------------------
  flake-utils = {
    url = "github:numtide/flake-utils";
  };
  flake-utils-plus = {
    url = "github:gytis-ivaskevicius/flake-utils-plus";
  };
  flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  flake-parts = {
    url = "github:hercules-ci/flake-parts";
  };

  # --- Hardware ---------------------------------
  nixos-hardware = {
    url = "github:NixOS/nixos-hardware";
  };
  lanzaboote = {
    url = "github:nix-community/lanzaboote";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
    inputs.rust-overlay.follows = "rust-overlay";
  };
  disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  impermanence =  {
    url = "github:nix-community/impermanence";
  };

  # --- Deployment -------------------------------
  colmena = {
    url = "github:zhaofengli/colmena";
    inputs.stable.follows = "nixpkgs";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };

  # --- Modules ----------------------------------
  nixvim = {
    url = "github:pta2002/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.utils.follows = "flake-utils";
  };
  # https://danth.github.io/stylix/configuration.html
  stylix = {
    url = "github:danth/stylix";
  };

  # --- Servers ----------------------------------
  firefly = {
    url = "github:timhae/firefly";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  nixos-mailserver = {
    url = "gitlab:lewo/nixos-mailserver";
  };
  nixcloud = {
    url = "github:nixcloud/nixcloud-webservices";
  };
  mineflake = {
    url = "github:nix-community/mineflake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  srvos = {
    url = "github:numtide/srvos";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # --- Generators -------------------------------
  nix2container = {
    url = "github:nlewo/nix2container";
  };
  nixos-generators = {
    url = "github:nix-community/nixos-generators";
  };

  # --- Individual Packages ----------------------
  lldap = {
    url = "github:NickCao/lldap";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
    inputs.rust-overlay.follows = "rust-overlay";
  };
  neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
  };

  # --- NUR Repos --------------------------------
  #nur-local = {
  #  url = "path:./.nur";
  #  inputs.nixpkgs.follows = "nixpkgs";
  #};
  #nur-repo = {
  #  url = "github:publicSam/nur-packages";
  #  inputs.nixpkgs.follows = "nixpkgs";
  #};

}
