{ inputs, lib, pkgs, config, osConfig, ... }:
let
  sys = pkgs.stdenv.system;
  hasFzf = (config.programs.fzf.enable || osConfig.programs.fzf.enable);
  hasVim = #builtins.trace (
    config.programs.vim.enable    || #osConfig.programs.vim.enable   ||
    config.programs.neovim.enable || osConfig.programs.neovim.enable ||
    config.programs.nixvim.enable || osConfig.programs.nixvim.enable
  #) osConfig
  ;
  sed=lib.getExe pkgs.gnused;
  manix="${lib.getExe' pkgs.expect "unbuffer"} ${lib.getExe pkgs.manix}";
  fzf=lib.getExe config.programs.fzf.package;
  grep=lib.getExe config.programs.ripgrep.package;
in
{
  home = {
    packages = [
      pkgs.expect
      # --- Documentation ------
      pkgs.manix # Fast documentation searcher for Nix
      pkgs.nix-doc # Nix documentation CLI

      # --- Diffs ---
      pkgs.nvd # Nix version diff tool
      pkgs.niff # Compares two Nix expressions & determines what attributes changed
    ] ++ lib.optional hasFzf pkgs.nur.repos.mrcpkgs.manix-fzf # Manix FZF interface
    #++ lib.optional hasVim pkgs.vimPlugins.telescope-manix # Manix Telescope plugin
    ;
    shellAliases = let
      prefix=''${manix} "" | ${grep} '^# ' | sed 's/^# (.*) (.*/1/;s/ (.*//;s/^# //' | sort | '';
      fz=''${fzf} --ansi --preview="${manix} '{}'" | '';
      suffix=''xargs ${manix}'';
      fzf-n = prefix + suffix;
      fzf-y = prefix + fz + suffix;
        #''${manix} "" | ${grep} '^# ' | sed 's/^# (.*) (.*/1/;s/ (.*//;s/^# //' | ${fzf} --ansi --preview="${manix} '{}'" | xargs ${manix}'';
      m = if hasFzf then fzf-y else fzf-n;
    in
    {
      nix-manix=m;
      n-manix=m;
      n-doc = m;
      #manix-fzf=lib.mkIf hasFzf fzf-y;
      fzf-manix=lib.mkIf hasFzf fzf-y;
    };
  };
}
