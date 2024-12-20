{ config, lib, pkgs, ... }:
{

  imports = [
    ./libreoffice.nix
  ];

  programs.fuse.userAllowOther = true;

  environment.systemPackages = [
    pkgs.fuse3
    pkgs.thunderbird
  ];

}
