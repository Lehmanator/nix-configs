{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.colorschemes = {
    base16 = {
      enable = false;
      colorscheme = "material";
    };

    gruvbox = {
      enable = false;
      bold = true;
      colorColumn = "bg";
      contrastDark = "medium";
      contrastLight = "medium";
      improvedStrings = true;
      improvedWarnings = true;
      italicizeComments = false;
      italicizeStrings = false;
      italics = true;
      numberColumn = "bg";
      signColumn = "bg";
      transparentBg = true;
      undercurl = false;
      underline = false;
    };

    nord = {
      enable = false;
      enable_sidebar_background = true;
      borders = true;
      contrast = false;
      cursorline_transparent = true;
      disable_background = true;
      italic = true;
    };

    tokyonight = {
      enable = false;
      #dayBrightness = 1;
      dimInactive = true;
      hideInactiveStatusline = true;
      lualineBold = true;
      #onColors = "function(colors) end";
      #onHighlights = "function(highlights, colors) end";
      sidebars = [ "qf" "help" ];
      #style = "storm";
      styles = {
        comments.italic = true;
        floats = "transparent";
      };
      terminalColors = true;
      transparent = true;
    };

  };

}
