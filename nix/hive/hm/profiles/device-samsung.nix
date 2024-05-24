{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #../os/android
  ];

  home.packages = [
    #pkgs.heimdall
    pkgs.heimdall-gui
  ];
}
