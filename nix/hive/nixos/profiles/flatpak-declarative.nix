{ inputs, lib, pkgs, user, ... }: {
  imports = [
    #inputs.declarative-flatpak.nixosModules.declarative-flatpak
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.self.nixosProfiles.flatpak
  ];

  services.flatpak = {
    uninstallUnmanaged = false;
    packages = lib.mkDefault [ ];
    overrides = {
      global.filesystems = lib.mkDefault [
        "xdg-config:gtk-4.0:ro"
        "xdg-config:gtk-3.0:ro"
        "xdg-config:gtk-2.0:ro"
      ];
    };
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
      {
        name = "gnome-nightly";
        location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";
      }
    ];
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };

  home-manager.sharedModules = [
    #inputs.declarative-flatpak.homeManagerModules.declarative-flatpak
    inputs.nix-flatpak.homeManagerMoodules.nix-flatpak
    #inputs.self.homeProfiles.flatpak-declarative
  ];
}
