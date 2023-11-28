{ inputs
, lib
, ...
}:
let
  colorscheme = "catppuccin";
in
{
  imports = [
    ./base16.nix
    ./catppuccin.nix
    ./gruvbox.nix
    ./nord.nix
    ./tokyonight.nix
  ];
  programs.nixvim.colorschemes.${colorscheme}.enable = true;
}
