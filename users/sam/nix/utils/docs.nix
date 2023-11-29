{ inputs, lib, pkgs, config, osConfig, ... }:
let
  sys = pkgs.stdenv.system;
  hasVim = #builtins.trace (
    config.programs.vim.enable   || #osConfig.programs.vim.enable ||
    config.programs.neovim.enable || osConfig.programs.neovim.enable ||
    config.programs.nixvim.enable || osConfig.programs.nixvim.enable
  #) osConfig
  ;
  hasFzf = (config.programs.fzf.enable || osConfig.programs.fzf.enable);
in
{
  imports = [
  ];
  home.packages = [
    # --- Documentation ------
    pkgs.manix # Fast documentation searcher for Nix
    pkgs.nix-doc # Nix documentation CLI

    # --- Diffs ---
    pkgs.nvd # Nix version diff tool
    pkgs.niff # Compares two Nix expressions & determines what attributes changed

  ] #++ lib.optional hasVim pkgs.vimPlugins.telescope-manix # Manix Telescope plugin
    ++ lib.optional hasFzf pkgs.nur.repos.mrcpkgs.manix-fzf # Manix FZF interface
  ;
}
