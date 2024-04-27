{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.emmet = {
    enable = false;
    #settings = {
    #  leader = null;
    #  mode = null; # i | n | v | a
    #};
  };
}
