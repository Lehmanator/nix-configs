{ inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.colorschemes.gruvbox = {
    #enable = lib.mkDefault false;
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
}
