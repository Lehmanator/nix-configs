{ config, lib, pkgs, ... }:
let
  hasVim   = config.programs.neovim.enable || config.programs.vim.enable;
  hasFzf   = config.programs.fzf.enable;
  hasSkim  = config.programs.skim.enable;
  hasFuzzy = hasFzf || hasSkim; 
  fuzzyPackage = 
    if hasSkim then config.programs.skim.package else
    if hasFzf  then config.programs.fzf.package  else pkgs.fzf;

  # --- Script Package -------------------------------------
  # Based on NUR package:
  #   Package Name:  `pkgs.nur.repos.mrcpkgs.manix-fzf`
  #   [Package Definition](https://github.com/mrcjkb/nur-packages/blob/master/pkgs/manix-fzf/derivation.nix)
  # TODO: Nushell-based script
  # TODO: use uutils-rs instead of gnused?
  # TODO: Gate behind `programs.fzf.enable` & `programs.skim.enable`
  # TODO: Allow using skim instead of fzf.
  manix-fuzzy = pkgs.writeShellApplication {
    name = "manix-fuzzy";
    runtimeInputs = [
      pkgs.manix
      pkgs.ripgrep
      pkgs.fzf     # TODO: Remove after adapting script
      fuzzyPackage
    ];

    text = "manix \"\" | rg '^# ' | sed 's/^# \\(.*\\) (.*/\\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";

    # My version:
    # text = "manix \"\" | rg '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
  };
in
{
  home = {
    packages = [
      pkgs.manix
    ] ++ lib.optional hasFuzzy manix-fuzzy
      ++ lib.optional hasVim   pkgs.vimPlugins.telescope-manix
    ;
    shellAliases = lib.mkIf hasFuzzy {
      nix-manix = "manix-fuzzy";
      n-manix   = "manix-fuzzy";
      n-doc     = "manix-fuzzy"; 
    };
  };

  # --- Editor Integration ---------------------------------
  # TODO: Neovim integration
  # TODO: Helix integration
  # TODO: Codium integration
}
