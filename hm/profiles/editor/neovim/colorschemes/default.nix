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
    #./nord.nix  # Seems to have been removed?
    ./tokyonight.nix
  ];
  programs.nixvim.colorschemes.${colorscheme}.enable = true;
}
