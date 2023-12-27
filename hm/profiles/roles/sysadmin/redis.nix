{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = with pkgs; [ redis-dump resp-app iredis rdbtools redli webdis ];
}
