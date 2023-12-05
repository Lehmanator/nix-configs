{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./flatpak.nix
    ./rofi.nix
    ./fonts.nix
  ];
}
