{ inputs, config, lib, pkgs, ... }: {
  specialisation = {
    # Convert NixOS configuration into mobile-friendly version
    mobile = {
      inheritParentConfig = true;
      configuration = {
        imports = [
          #inputs.mobile.
          inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
        ];
        system.nixos.tags = [ "mobile" ];
      };
    };

    # Virtualize NixOS configuration as guest VM
    vm-guest = {
      inheritParentConfig = true;
      configuration = {
        imports = [ ];
        system.nixos.tags = [ "virtualized" "vm" "vm-guest" ];
      };
    };

    # Add guest user to configuration
    guest-user = {
      inheritParentConfig = true;
      configuration = {
        imports = [ ];
        system.nixos.tags = [ "guest-user" ];
      };
    };

    # Make configuration an installer
    installer = {
      inheritParentConfig = true;
      configuration = {
        imports = [ ];
        system.nixos.tags = [ "installer" "bootstrap" ];
      };
    };

    # Enable Full Disk Encryption (FDE) with configuration
    encrypted = {
      inheritParentConfig = true;
      configuration = {
        imports = [ inputs.disko.nixosModules.disko ];
        system.nixos.tags = [ "encrypted" "fde" ];
      };
    };

    # Enable Secure Boot on configuration
    secureboot = {
      inheritParentConfig = true;
      configuration = {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
        nixpkgs.overlays = [ inputs.lanzaboote.overlays.default ];
        boot.lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
        system.nixos.tags = [ "secureboot" ];
        system.nixos.variant_id = "secureboot";
      };
    };

    autoupgrade-stable = {
      inheritParentConfig = true;
      configuration = {
        system.autoUpgrade = {
          enable = true;
          allowReboot = true;
          flake =
            "github:PresqueIsleWineDev/nix-configs"; # TODO: Make sure correct
        };
        system.nixos.tags = [ "autoupgrade" "stable" ];
      };
    };
  };
}
