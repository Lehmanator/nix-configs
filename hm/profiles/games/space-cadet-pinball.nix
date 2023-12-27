{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];
  home.packages = [ pkgs.nur.repos.xddxdd.space-cadet-pinball-full-tilt ];
}
