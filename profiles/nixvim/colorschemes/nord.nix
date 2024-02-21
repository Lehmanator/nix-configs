{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  colorschemes.nord = {
    #enable = lib.mkDefault false;
    enable_sidebar_background = lib.mkDefault true;
    borders = lib.mkDefault true;
    contrast = lib.mkDefault false;
    cursorline_transparent = lib.mkDefault true;
    disable_background = lib.mkDefault true;
    italic = lib.mkDefault true;
  };
}
