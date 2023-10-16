{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.heimdall
    pkgs.heimdall-gui
  ];
}
