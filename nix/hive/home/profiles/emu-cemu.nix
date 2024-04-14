{ inputs, config, lib, pkgs, ... }:
{
  imports = [
  ];

  # Wii U emulator
  home.packages = [
    pkgs.cemu
    #pkgs.nur.repos.mcaju.decaf-emu
    #pkgs.nur.repos.jakobrs.joycond  # Breaks: libudev renamed to udev
  ];
}
