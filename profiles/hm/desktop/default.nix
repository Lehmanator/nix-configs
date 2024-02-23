{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./audio.nix
    ./flatpak.nix
    ./rofi.nix
    ./fonts.nix

    #./polybar.nix
    #./touchpad.nix
    #./udiskie.nix
    #./wayland.nix
  ];
}
