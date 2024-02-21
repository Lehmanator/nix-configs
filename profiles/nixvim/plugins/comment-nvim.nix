{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  plugins.comment-nvim = {
    enable = lib.mkDefault true;
    mappings = {
      basic = true;
      extended = true;
      extra = true;
    };
    padding = false;
    #sticky = false;
  };
}
