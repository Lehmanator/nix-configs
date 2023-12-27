{ config, lib, pkgs, ... }:
{
  environment = {

    # TODO: Use ripgrep instead of grep
    # TODO: Use binary path to manix
    # TODO: Other manix aliases?
    shellAliases = {
      nix-manix = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
      n-manix = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
      n-doc = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
    };
    systemPackages = [ pkgs.manix ];
  };
}
