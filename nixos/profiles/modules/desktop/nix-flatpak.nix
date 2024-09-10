{ inputs, config, lib, pkgs, ... }: {
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  home-manager.sharedModules = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    enable = lib.mkDefault true;
    remotes = [
      { name = "flathub-beta";  location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      { name = "flathub";       location = "https://dl.flathub.org/repo/flathub.flatpakrepo";        }
    ] ++ lib.optional config.services.xserver.desktopManager.gnome.enable 
      { name = "gnome-nightly"; location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";    }
    ;
    packages = [
      {origin="flathub"; appId="com.github.tchx84.Flatseal";          }
      {origin="flathub"; appId="io.github.giantpinkrobots.flatsweep"; }
      {origin="flathub"; appId="io.github.flattool.Warehouse";        }
    ];
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
    overrides = {
      global = {
        Context.filesystems = [
          "xdg-config:gtk-4.0:ro"
          "xdg-config:gtk-3.0:ro"
          "xdg-config:gtk-2.0:ro"
          "xdg-data:icons:ro"
          "xdg-data:fonts:ro"
        ];
        Environment = {
          # XCURSOR_PATH = "/run/current-system/sw/share/icons:/run/host/share/icons";
        };
      };
    };
  };
}
