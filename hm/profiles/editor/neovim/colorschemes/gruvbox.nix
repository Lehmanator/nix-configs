{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.colorschemes.gruvbox = {
    #enable = lib.mkDefault false;
    settings = {
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
      undercurl = false;
      underline = false;
      transparentBg = true;
    };
  };
}
