{
  inputs,
  lib,
  ...
}: let
  colorscheme = "catppuccin";
in {
  imports = [
    ./base16.nix
    ./catppuccin.nix
    ./gruvbox.nix
    #./nord.nix  # Seems to have been removed?
    ./tokyonight.nix
  ];
  colorschemes.${colorscheme}.enable = true;
}
