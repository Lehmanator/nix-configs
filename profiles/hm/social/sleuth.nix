{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ];
  home.packages = with pkgs; [
    instaloader
    sherlock
    socialscan
    snscrape
  ];
}
