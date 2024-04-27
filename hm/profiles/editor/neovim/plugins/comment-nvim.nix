{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.comment-nvim = {
    enable = lib.mkDefault true;
    #settings = {
    mappings = {
      basic = true;
      extra = true;
    };
    padding = false;
    #sticky = false;
    #};
  };
}
