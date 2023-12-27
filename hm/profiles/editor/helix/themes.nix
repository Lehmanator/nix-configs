{ self, inputs
, config, lib, pkgs
, ...
}:
let

  # TODO: Create themes that match light/dark themes of BlackBox terminal
  themes.blackbox.light = [
    "Dracula Light"
    "Pencil Light"
    "Solarized Light"
    "Tomorrow"
  ];
  themes.blackbox.dark = [
    "base16-twilight-dark"
    "Dracula"
    "Japanesque"
    "Material"
    "Monokai Dark"
    "One Dark"
    "Orchis"
    "Pencil Dark"
    "Solarized Dark"
    "Tomorrow Night"
    "Yaru"
  ];

  themes.helix.light = [
  ];
  themes.helix.dark = [
  ];
  themes.helix.system = [
    "base16_terminal"
    "base16_transparent"
  ];

  transparent = "none";
in
{

  imports = [
    #./themes
  ];

  programs.helix.themes = {

    a-shell = {
      inherits = "base16_terminal";

      ui = {
        gutter = { fg = "gray"; };
        linenr = {
          fg = "gray";
          selected = { fg = "blue"; modifiers = ["bold"]; };
        };
        statusline = {
          fg = "gray";
          normal = { fg = "black"; bg = "green";  modifiers = ["bold"]; };
          insert = { fg = "black"; bg = "blue";   modifiers = ["bold"]; };
          select = { fg = "black"; bg = "orange"; modifiers = ["bold"]; };
        };
        virtual.indent-guide = { fg = "gray"; modifiers = ["dim"]; };

      };
      #"ui.background" = transparent;
      #"ui.gutter" = { bg = transparent; fg = "light-gray"; };
      #"ui.statusline.inactive" = { bg = transparent; fg = "light-gray"; };
      #"ui.statusline.normal" = { bg = };
    };

  };

}

# Modifiers: bold, dim, italic, underlined, slow_blink,
#            rapid_blink, reversed, hidden, crossed_out
# Underline Style: line, curl, dashed, dotted, double_line
#
