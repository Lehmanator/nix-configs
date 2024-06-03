{
  description = "Extra flake inputs for NixOS";

  # --- Nixpkgs ----------------------------------------------------------------
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

  # --- Hardware-Related -------------------------------------------------------
  inputs = {
    nixos-images.url = "github:nix-community/nixos-images";

    # --- Filesystems ---
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

    # --- Hardware ---
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # --- Secure Boot ---
    lanzaboote.url = "github:nix-community/lanzaboote";

    # --- Framework ---
    fprint-clear.url = "github:nixvital/fprint-clear";
  };

  # --- Desktop Related --------------------------------------------------------
  inputs = {

    # --- Flatpak ---
    declarative-flatpak.url = "github:GermanBread/declarative-flatpak";
    nix-flatpak.url = "github:/nix-flatpak";

    # --- Graphics ---
    nixGL.url = "github:guibou/nixGL";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # --- GTK Apps ---
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixpkgs-gnome-apps.url = "github:chuangzhu/nixpkgs-gnome-apps";

    # --- Colors & Themes ---
    matugen.url = "github:/InioX/Matugen";

    # --- Browsers ---
    browser-previews.url = "github:nix-community/browser-previews";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";

    # --- Desktop Environments ---
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # --- Mobile -----------------------------------------------------------------
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

  # --- System Configs ---------------------------------------------------------
  # TODO: Move ez-configs to ../flake-parts/flake.nix ?
  inputs = {
    ez-configs.url = "github:ehllie/ez-configs";
    srvos.url = "github:nix-community/srvos";
    nix-remote-rust.url = "github:tweag/nix-remote-rust";
  };

  # --- Server Related ---------------------------------------------------------
  inputs = {
    # --- Matrix ---
    conduwuit.url = "github:girlbossceo/conduwuit";
  };


  # --- Normalization ----------------------------------------------------------
  inputs = {
    envfs.url = "github:Mic92/envfs";
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # nixosModules ---------------------------------------------------------------
  inputs = {
    # --- Docker Compose ---
    arion = {
      url = "github:hercules-ci/arion";
      #inputs.flake-parts.follows = "flake-parts";
    };

    # --- Backups ---
    snapshotter = {
      url = "github:pdtpartners/nix-snapshotter";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        #flake-parts.follows = "flake-parts";
        #flake-compat.follows = "";
      };
    };
  };

  # nixosModules: Operate on nixosConfigurations -------------------------------
  inputs = {
    # --- Deployment ---
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- Generators ---
    nixos-generators.url = "github:nix-community/nixos-generators";
    microvm = {
      url = "github:astro/microvm.nix";
      #inputs.flake-utils.follows = "flake-utils";
    };
  };


  # nixosModules: Server Types -------------------------------------------------

  # NixOS-Related Packages -----------------------------------------------------
  inputs = {

    # --- nushell ---
    nuenv = {
      url = "github:DeterminateSystems/nuenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = _: { };
}
