{ inputs
, ...
}:
{
  imports = [
    ./base16.nix
    ./catppuccin.nix
    ./gruvbox.nix
    ./nord.nix
    ./tokyonight.nix
  ];
  programs.nixvim.colorschemes.catppuccin.enable = true;
}
