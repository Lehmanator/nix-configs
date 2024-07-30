{ config, lib, pkgs, user, ... }: {
  #, flatpak-repos ? { flathub = "https://flathub.org/repo/flathub.flatpakrepo"; }

  # --- Package Info Integration ---
  appstream.enable = true;
  services = {
    flatpak.enable = true;
    packagekit.enable = true;
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
