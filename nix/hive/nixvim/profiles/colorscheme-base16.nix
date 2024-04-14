{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  colorschemes.base16 = {
    #enable = lib.mkDefault false;
    colorscheme = "material";
  };
}
