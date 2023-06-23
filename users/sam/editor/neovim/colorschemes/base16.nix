
{ inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.colorschemes.base16 = {
    enable = lib.mkDefault false;
    colorscheme = lib.mkDefault "material";
  };
}
