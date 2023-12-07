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
    #./iso.nix
    #./arcropolis.nix
    #./arena-latency-slider.nix
    #./lessdelay.nix
    #./hdr.nix
    #./training-modpack.nix
    #./visualizer.nix
  ];

  gtk.gtk3.bookmarks = [
    "${ns-ftp}/ultimate/mods NS-ARCropolis"
    "${ns-ftp}/ultimate/TrainingModpack NS-TrainingModpack"
    "${ns-ftp}/atmosphere/contents/01006A800016E000/romfs/skyline/plugins NS-Skyline"
    "${ns-ftp}/atmosphere/contents/01006A800016E000/romfs/minecraft_skins NS-MinecraftSkins"
  ];
}
