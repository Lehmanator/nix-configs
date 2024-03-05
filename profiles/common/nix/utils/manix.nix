{ config, pkgs, lib, ... }:
let
  inherit (lib) getExe getExe' optional;
  grep = getExe pkgs.ripgrep; # pkgs.ripgrep-all; #pkgs.gnugrep;
  fzf = getExe pkgs.fzf;
  manix = getExe pkgs.manix;
  sed = getExe pkgs.gnused;
  #xargs = getExe' pkgs.findutils "xargs";

  hasVim = optional (config.programs.vim.defaultEditor
    || config.programs.neovim.enable
    || (config.programs ? nixvim && config.programs.nixvim.enable));
  manix-alias = ''
    ${manix} "" | ${grep} '^# ' | ${sed} 's/^# (.*) (.*/1/;s/ (.*//;s/^# //' | sort | ${fzf} --preview="${manix} '{}'" | xargs ${manix}'';
in
{
  environment = {
    systemPackages = [ pkgs.manix ] ++ hasVim pkgs.vimPlugins.telescope-manix;
    shellAliases = {
      nix-manix = manix-alias;
      n-manix = manix-alias;
      n-doc = manix-alias;
    };
  };
}
