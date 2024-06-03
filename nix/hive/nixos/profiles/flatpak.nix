{ inputs, config, lib, pkgs, user, ... }:
#, flatpak-repos ? { flathub = "https://flathub.org/repo/flathub.flatpakrepo"; }
{
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  # --- Package Info Integration ---
  appstream.enable = true;
  services = {
    flatpak.enable = true;
    packagekit.enable = true;
  };

  # --- Fonts ---
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
  };

  # Rebuild font cache upon system activation
  #system.activationScripts.flatpakSystem.text = ''
  #  # TODO: Replace with primary user
  #  fc-cache -rf
  #  ln -s /run/current-system/sw/share/X11/fonts /home/sam/.local/share/fonts
  #'';

  # --- Flatpak CLI ---
  environment.shellAliases = {
    fp = "flatpak";
    fpb = "flatpak build";
    fpi = "flatpak install";
    fpo = "flatpak override";
    fps = "flatpak search";
    fpun = "flatpak uninstall";
    fpup = "flatpak update";
    fpu = "flatpak update";
  };

  users.users."${user}".extraGroups = [ "flatpak" ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
#(lib.optionalAttrs (options?services.flatpak.packages) {
#  imports = [ ./flatpak-apps.nix ];
#  services.flatpak.remotes = flatpak-repos;
#  services.flatpak.preInitCommand = "";
#  services.flatpak.postInitCommand = "";
#  services.flatpak.packages = [
#    "flathub:org.freedesktop.Sdk"
#    "flathub:org.freedesktop.Platform"
#    "flathub:org.freedesktop.Platform.ffmpeg-full"
#    "flathub:org.freedesktop.Platform.html5-codecs"
#    "flathub:org.freedesktop.Platform.openh264"
#    "flathub:org.freedesktop.Platform.GL.default"     # TODO: Conditional if using OpenGL graphics
#    "flathub:org.freedesktop.Platform.VAAPI.Intel"    # TODO: Conditional if using Intel graphics & VAAPI
#    "flathub:org.freedesktop.LinuxAudio.Plugins.Calf"
#    "flathub:org.freedesktop.LinuxAudio.Plugins.LSP"
#    "flathub:org.freedesktop.LinuxAudio.Plugins.MDA"
#    "flathub:org.freedesktop.LinuxAudio.Plugins.swh"
#    "flathub:org.freedesktop.LinuxAudio.Plugins.ZamPlugins"
#  ];
#})
