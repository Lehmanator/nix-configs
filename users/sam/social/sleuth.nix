{ self, inputs, system, config, lib, pkgs, ... }: let
in {
  imports = [];

  home.packages = with pkgs; [

    instaloader
    sherlock
    socialscan
    snscrape

  ];
}
