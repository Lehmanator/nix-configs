{ inputs, lib, pkgs, config, ... }:
{
  imports = [
    #inputs.nixpkgs-gnome-mobile.nixosModules.default
    ./gtk-apps.nix
  ];

  # Overlay our mobile forks of gnome-shell & mutter.
  #nixpkgs.overlays = [ (import ../../overlays/gnome-mobile) ]; #(import inputs.self.overlays.gnome-mobile)

  services.xserver = {
    enable = true;
    desktopManager = {
      phosh.enable = lib.mkDefault false;
      gnome.enable = true;
    };
  };

  #  videoDrivers = [ "modesetting" ];
  #  displayManager = {
  #    defaultSession = lib.mkForce "gnome";
  #    gdm.enable = lib.mkForce true;
  #  };
  #
  #  # Set workspaces so they work with mobile GNOME shell.
  #      enable = lib.mkForce true;
  #      extraGSettingsOverrides = ''
  #        [org.gnome.mutter]
  #        dynamic-workspaces=true
  #      '';
  #      extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  #    };
  #  };
  #};

}
