{ inputs, config, lib, pkgs, ... }:
{
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = false;

    # Configure flatpak remote repos
    remotes = [
      {name="flathub-beta";  location="https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      {name="flathub";       location="https://dl.flathub.org/repo/flathub.flatpakrepo";        }
    ] ++ lib.optional config.services.xserver.desktopManager.gnome.enable 
      {name="gnome-nightly"; location="https://nightly.gnome.org/gnome-nightly.flatpakrepo";    }
    ;

    # Install flatpak packages
    packages = [
      {origin="flathub"; appId="com.github.tchx84.Flatseal";          }
      {origin="flathub"; appId="io.github.giantpinkrobots.flatsweep"; }
      {origin="flathub"; appId="io.github.flattool.Warehouse";        }
    ] ++ lib.optionals config.gtk.enable [  # TODO: Conditional when using adw-gtk package as GTK theme.
      {origin="flathub"; appId="org.gtk.Gtk3theme.adw-gtk3";      }
      {origin="flathub"; appId="org.gtk.Gtk3theme.adw-gtk3-dark"; }
      {origin="flathub"; appId="org.kde.KStyle.Adwaita";          }
    ];

    # Overrides for GTK config, CSS, & icon/font dirs
    overrides.global.Context.filesystems = [
      "xdg-config/gtk-4.0:ro"
      "xdg-config/gtk-3.0:ro"
      "xdg-config/gtk-2.0:ro"
      "xdg-data/icons:ro"
      "xdg-data/fonts:ro"
    ];
  };
  
  home.shellAliases = let
    args = lib.cli.toGNUCommandLineShell {} {
      assumeyes = true;
      noninteractive = false;
    };
  in rec {
    fp   = "flatpak";
    fpb  = fp + " build";
    fpo  = fp + " override";
    fps  = fp + " search";
    fpun = fp + " uninstall";
    fpi  = fp + " install --or-update" + args;
    fpup = fp + " update " + args;
    fpu  = fpup;
  };
}

#
#(lib.optionalAttrs (lib.hasAttrByPath ["services" "flatpak" "packages"] options) {
#  services.flatpak = {
#    remotes = flatpak-repos;
#    preInitCommand = "";
#    postInitCommand = "";
#    flatpak.packages = [ ]; # TODO: Add all default packages (runtimes, SDKs, themes, libs, plugins, codecs, etc.)
#  };
#})
