{ inputs, self, lib, pkgs, config, osConfig, ... }:
let
  sys = pkgs.stdenv.system;
  hasVim = #builtins.trace (
    config.programs.nixvim.enable || osConfig.programs.nixvim.enable ||
    config.programs.neovim.enable || osConfig.programs.neovim.enable ||
    config.programs.vim.enable    || osConfig.programs.vim.enable
  #) osConfig
  ;
  #hasFzf = config.programs.fzf.enable; #|| osConfig.programs.fzf.enable;
in
{
  imports = [
  ];
  home.packages = [
    # --- LSPs ---
    #pkgs.nil # Language server
    #pkgs.none-ls # Language server
    #pkgs.nixd # Language server
    #pkgs.rnix-lsp # Language server

    # --- Checkers / Linters / Formatters ---
    pkgs.alejandra # Nix code formatter
    pkgs.deadnix # Check for unreachable code

  ] ++ lib.optional hasVim pkgs.vimPlugins.statix # Use statix in vim
    ++ lib.optional hasVim pkgs.vimPlugins.none-ls-nvim # LSP Vim plugin
  ;
}
