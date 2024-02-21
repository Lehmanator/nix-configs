{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  colorschemes.tokyonight = {
    #enable = lib.mkDefault false;
    #dayBrightness = 1;
    dimInactive = lib.mkDefault true;
    hideInactiveStatusline = lib.mkDefault true;
    lualineBold = lib.mkDefault true;
    #onColors = "function(colors) end";
    #onHighlights = "function(highlights, colors) end";
    sidebars = ["qf" "help"];
    #style = "storm";
    styles = {
      comments.italic = lib.mkDefault true;
      floats = lib.mkDefault "transparent";
    };
    terminalColors = lib.mkDefault true;
    transparent = lib.mkDefault true;
  };
}
