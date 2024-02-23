{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./arcropolis.nix
    #./arena-latency-slider.nix
    #./lessdelay.nix
    #./hdr.nix
    #./training-modpack.nix      # Import: ./skyline-dev.nix
    #./skyline-dev.nix
  ];

  home.packages = [
    pkgs.yuzu-early-access # Nintendo Switch (experimental preview version) #pkgs.nur.repos.ivar.yuzu-ea
    #pkgs.yuzu-mainline    # Nintendo Switch (mainline branch version)      #pkgs.nur.repos.ivar.yuzu-mainline
    #pkgs.nur.repos.jakobrs.joycond  # Breaks: libudev renamed to udev
  ];
}
