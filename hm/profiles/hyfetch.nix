{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.onefetch  # Fetcher for Git repo info
    pkgs.ramfetch  # Fetcher for RAM data
    pkgs.ipfetch   # Fetcher for IP address data (broken?)
  ];

  programs.hyfetch = {
    enable = true;
    # settings = {
    #   preset = "rainbow";
    #   mode = "rgb";
    #   color_align = {
    #     mode = "horizontal";
    #   };
    # };
  };
}
