{ inputs
, config
, lib
, pkgs
, ...
}:
let
  # TODO: Move to secret
  ns-ip = "192.168.1.20";
  ns-ftp-port = "43021";
  ns-ftp = "ftp://${ns-ip}/${ns-ftp-port}";
in
{
  imports = [
    ./developer
    ./emu
    ./smash
  ];

  # TODO: Config for real NS console -> ../devices/nintendo-switch.nix
  # TODO: Make mods directory/SD-card so can be shared b/w console, ryujinx, & yuzu

  # --- Nintendo Switch FTP Server ---------------------------
  # TODO: Mount base FTP server for `sys-ftpd`
  # TODO: Pass through FTP server clip dir thru ffmpeg FUSE fs to convert clips
  # TODO: Mount <year>/<month> subdir for clips.
  gtk.gtk3.bookmarks = [
    "${ns-ftp} NS"
    "${ns-ftp}/Nintendo/Album/2023/12 NS-Clips"
  ];

  # --- Controller Support -----------
  home.packages = [
    #pkgs.nur.repos.jakobrs.joycond  # Breaks: libudev renamed to udev
  ];

}
