{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.redis-dump
    pkgs.resp-app
    pkgs.iredis
    pkgs.rdbtools
    pkgs.redli
    #pkgs.webdis
  ];
}
