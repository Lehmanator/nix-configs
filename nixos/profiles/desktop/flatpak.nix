{ config, lib, pkgs, user, ... }: {
  # --- Package Info Integration ---
  appstream.enable = true;
  services = {
    packagekit.enable = true;
    flatpak = {
      enable = true;
      uninstallUnmanaged = false;
      remotes = [
        { name = "flathub-beta";  location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
        { name = "flathub";       location = "https://dl.flathub.org/repo/flathub.flatpakrepo";        }
      ] ++ lib.optional config.services.xserver.desktopManager.gnome.enable 
        { name = "gnome-nightly"; location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";    }
      ;
      packages = [
        { origin="flathub"; appId="com.github.tchx84.Flatseal";          }
        { origin="flathub"; appId="io.github.giantpinkrobots.flatsweep"; }
        { origin="flathub"; appId="io.github.flattool.Warehouse";        }
      ] ++ lib.optionals config.services.xserver.desktopManager.gnome.enable [
        { origin="flathub"; appId="org.gtk.Gtk3theme.adw-gtk3";          }
        { origin="flathub"; appId="org.gtk.Gtk3theme.adw-gtk3-dark";     }
        { origin="flathub"; appId="org.kde.KStyle.Adwaita";              }
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
            "xdg-config/gtk-4.0:ro"
            "xdg-config/gtk-3.0:ro"
            "xdg-config/gtk-2.0:ro"
            "xdg-data/icons:ro"
            "xdg-data/fonts:ro"
          ];
          Environment = {
            # XCURSOR_PATH = "/run/current-system/sw/share/icons:/run/host/share/icons";
          };
        };
      };
    };
  };

  # --- Fonts ---
  fonts = { fontconfig.enable = true; fontDir.enable = true; };

  # Rebuild font cache upon system activation
  #system.activationScripts.flatpakSystem.text = ''
  #  # TODO: Replace with primary user
  #  fc-cache -rf
  #  ln -s /run/current-system/sw/share/X11/fonts /home/sam/.local/share/fonts
  #'';


  # --- Flatpak CLI ---
  users.users."${user}".extraGroups = [ "flatpak" ];
  environment.shellAliases = let
    args = lib.cli.toGNUCommandLineShell {} {
      assumeyes = true;
      noninteractive = false;
    };
  in rec {
    fp = "flatpak";
    fpb = fp + " build";
    fpi = fp + " install --or-update" + args;
    fpo = fp + " override";
    fps = fp + " search";
    fpun = fp + " uninstall";
    fpup = fp + " update " + args;
    fpu = fpup;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}

#(lib.optionalAttrs (lib.hasAttrByPath ["services" "flatpak" "packages"] options) {
#  imports = [ ./flatpak-apps.nix ];
#  services.flatpak = {
#    remotes = flatpak-repos;
#    preInitCommand  = "";
#    postInitCommand = "";
#    packages = [
#      "flathub:org.freedesktop.Sdk"
#      "flathub:org.freedesktop.Platform"
#      "flathub:org.freedesktop.Platform.ffmpeg-full"
#      "flathub:org.freedesktop.Platform.html5-codecs"
#      "flathub:org.freedesktop.Platform.openh264"
#      "flathub:org.freedesktop.Platform.GL.default"     # TODO: Conditional if using OpenGL graphics
#      "flathub:org.freedesktop.Platform.VAAPI.Intel"    # TODO: Conditional if using Intel graphics & VAAPI
#      "flathub:org.freedesktop.LinuxAudio.Plugins.Calf"
#      "flathub:org.freedesktop.LinuxAudio.Plugins.LSP"
#      "flathub:org.freedesktop.LinuxAudio.Plugins.MDA"
#      "flathub:org.freedesktop.LinuxAudio.Plugins.swh"
#      "flathub:org.freedesktop.LinuxAudio.Plugins.ZamPlugins"
#    ];
#  };
#})
