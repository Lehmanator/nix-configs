{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    redis-dump
    resp-app
    #iredis # Broken as of 1/15/23
    rdbtools
    redli
    webdis
  ];
}
