{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];
  home.packages = [ pkgs.tor-browser-bundle-bin ];
}
