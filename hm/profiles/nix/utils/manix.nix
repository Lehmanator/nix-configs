{ config, lib, pkgs, ... }:
{
  # TODO: Use ripgrep instead of grep
  # TODO: Use binary path to manix
  # TODO: Other manix aliases?
  home.shellAliases = rec {
    nix-manix = "${lib.getExe pkgs.manix} \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
    n-manix   = nix-manix;
    n-doc     = nix-manix; 
  };
}
