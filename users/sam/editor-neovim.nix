{
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.withNodeJs = true;
  programs.neovim.withPython3 = true;
  
  programs.neovim.plugins = with pkgs.vimPlugins; [
    { plugin = nvim-treesitter.withAllGrammars; }
  ];
}
