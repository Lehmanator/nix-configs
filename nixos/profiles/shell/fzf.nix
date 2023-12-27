{ config, lib, pkgs, ... }:
{
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

}
