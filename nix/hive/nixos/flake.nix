{
  description = "Extra flake inputs for NixOS";
  inputs = {
    # Base branches
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Small variants
    nixos-small-unstable.url = "github:NixOS/nixpkgs/nixos-small-unstable";
    nixos-small-stable.url = "github:NixOS/nixpkgs/nixos-23.11-small";

    # Short names
    nixpkgs.follows = "nixos-unstable";
    nixos.follows = "nixos-unstable";
    unstable.follows = "nixos-unstable";
    stable.follows = "nixos-stable";

    # Short names (small)
    small.follows = "nixoss-small-unstable";
    small-unstable.follows = "nixoss-small-unstable";
    small-stable.follows = "nixoss-small-stable";
  };

  # Hardware-Related
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fprint-clear.url = "github:nixvital/fprint-clear";
    impermanence.url = "github:nix-community/impermanence";
    nixos-images.url = "github:nix-community/nixos-images";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  # Desktop-Related
  inputs = {
    declarative-flatpak.url = "github:GermanBread/declarative-flatpak";
    nixGL.url = "github:guibou/nixGL";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixpkgs-gnome-apps.url = "github:chuangzhu/nixpkgs-gnome-apps";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  # Mobile
  inputs = {
    mobile-nixos = {
      url = "github:NixOS/mobile-nixos";
      flake = false;
    };
    mobile-nixos-dev = {
      url = "github:NixOS/mobile-nixos/development";
      flake = false;
    };
    mobile-nixos-sam = {
      url = "github:Lehmanator/mobile-nixos/update-firmware";
      flake = false;
    };
    mobile-nixos-sam-main = {
      url = "github:Lehmanator/mobile-nixos/main";
      flake = false;
    };
    mobile-nixos-sam-dev = {
      url = "github:Lehmanator/mobile-nixos/development";
      flake = false;
    };
    nixpkgs-gnome-mobile.url = "github:Lehmanator/nixpkgs-gnome-mobile/develop";
    nixos-mobile = {
      url = "github:vlinks/mobile-nixos/gnomelatest";
      flake = false;
    };
  };

  # System Configs
  # TODO: Move ez-configs to ../flake-parts/flake.nix ?
  inputs = {
    ez-configs.url = "github:ehllie/ez-configs";
    srvos.url = "github:nix-community/srvos";
  };

  # Server Related
  inputs = { };

  # nixosModules ---------------------------------------------------------------
  # nixosModules: Operate on nixosConfigurations
  inputs = {
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators.url = "github:nix-community/nixos-generators";
    microvm = {
      url = "github:astro/microvm.nix";
      #inputs.flake-utils.follows = "flake-utils";
    };
  };

  inputs = {
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      #inputs.flake-parts.follows = "flake-parts";
    };

    snapshotter = {
      url = "github:pdtpartners/nix-snapshotter";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        #flake-parts.follows = "flake-parts";
        #flake-compat.follows = "";
      };
    };
  };

  # NixOS-Related Packages -----------------------------------------------------
  inputs = {
    nuenv.url = "github:DeterminateSystems/nuenv";
    nuenv.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = _: { };
}
