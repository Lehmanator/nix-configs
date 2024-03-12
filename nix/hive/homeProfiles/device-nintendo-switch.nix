{ inputs
, config
, lib
, pkgs
, ns ? {
    ip = "192.168.1.20";
    port = "43021";
  }
, ...
}:
let
  # TODO: Move to secret
  ns-ip = "192.168.1.20";
  ns-ftp-port = "43021";
  ns-ftp = "${ns-ip}/${ns-ftp-port}";
in
{
  # TODO: Config for real NS console -> ../devices/nintendo-switch.nix
  # TODO: Make mods directory/SD-card so can be shared b/w console, ryujinx, & yuzu

  # --- Nintendo Switch FTP Server ---------------------------
  # TODO: Mount base FTP server for `sys-ftpd`
  # TODO: Pass through FTP server clip dir thru ffmpeg FUSE fs to convert clips
  # TODO: Mount <year>/<month> subdir for clips.
  gtk.gtk3.bookmarks = [
    "ftp://${ns-ftp} NS"
    "ftp://${ns-ftp}/Nintendo/Album/2024/03 NS-Clips"
    "ftp://${ns-ftp}/ultimate/mods NS-ARCropolis"
    "ftp://${ns-ftp}/ultimate/TrainingModpack NS-TrainingModpack"
    "ftp://${ns-ftp}/atmosphere/contents/01006A800016E000/romfs/skyline/plugins NS-Skyline"
    "ftp://${ns-ftp}/atmosphere/contents/01006A800016E000/romfs/minecraft_skins NS-MinecraftSkins"
  ];

  # --- Controller Support -----------
  home.packages = [
    pkgs.fusee-interfacee-tk
    pkgs.fusee-launcher
    pkgs.fusee-nano
    #pkgs.nur.repos.jakobrs.joycond  # Breaks: libudev renamed to udev
  ];

  services.flatpak.packages = lib.mkIf config.flatpak.enable
    [ "flathub:app/io.github.parnassius.SysDVR-Qt//stable" ];

  # TODO: Figure out where to write credentials for Nautilus mounts
  #sops.secrets = {
  #  nintendo-switch-ip = { };
  #  nintendo-switch-port = { };
  #  nintendo-switch-username = { };
  #  nintendo-switch-password = { };
  #};

  # TODO: systemd.user.tmpfiles.rules for Nintendo Switch controllers
  #systemd.user = {
  #  automounts.nintendo-switch = {
  #    # See `man systemd.unit(5)`
  #    Unit = {
  #      Description = "Automount: Nintendo Switch FTP Server";
  #      Documentation = [ "https://github.com/Cathery/sys-ftpd" ];
  #      SourcePath = "${inputs.self}/nix/hive/device-nintendo-switch.nix";
  #    };
  #    # See: `man systemd.automount(5)`
  #    Automount = {
  #      DirectoryMode = "0640";
  #      ExtraOptions = "_netdev";
  #      #TimeoutIdleSec = "";
  #      Where = "/mnt/ftp-nintendo-switch";
  #    };
  #  };
  #  mounts.nintendo-switch = {
  #    Unit = {
  #      Description = "Mount: Nintendo Switch FTP Server";
  #      Documentation = [ "https://github.com/Cathery/sys-ftpd" ];
  #      SourcePath = "${inputs.self}/nix/hive/device-nintendo-switch.nix";
  #    };
  #    # See: `man systemd.mount(5)`
  #    Mount = {
  #      What = "ftp://${ns.ip}";
  #      Options = "_netdev";
  #    };
  #  };
  #};
}
