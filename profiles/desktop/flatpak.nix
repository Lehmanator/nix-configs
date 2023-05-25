{ self, inputs
, config, lib, pkgs
, options
, system
, host
, userPrimary ? "sam"
, flatpak-repos ? { flathub = "https://flathub.org/repo/flathub.flatpakrepo"; }
, ...
}:
#lib.attrsets.recursiveUpdate
{
  services.flatpak.enable = true;
  services.packagekit.enable = true;
  appstream.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;
  system.activationScripts.flatpakSystem.text = ''
  ''; # TODO: Replace with primary user
    #fc-cache -rf
    #ln -s /run/current-system/sw/share/X11/fonts /home/sam/.local/share/fonts


  users.users."sam".extraGroups = [ "flatpak" ];

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
