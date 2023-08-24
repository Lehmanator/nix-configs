{ inputs, self
, config, lib, pkgs
, style ? "rounded"
, chars ? "devicons"
, emoji ? true
, powerline ? true
, devicons ? true
, unicode ? true
, ascii ? true
, ...
}:
#
# Charsets:  ascii | unicode | devicons | emoji
#   Styles:  round | angle   | square
#
# TODO: Make dir w/ files:
#  - Shapes:    round.nix,   angle.nix,   square.nix
#  - Charsets:  ascii.nix, unicode.nix, devicons.nix, emoji.nix
#
# TODO: Create lib to take system / home Nix config & build support matrix for various fonts, glyphs & symbols based on:
#  - installed monospaced fonts
#  - terminal character support
#  - terminal font configuration
#
# TODO: Enumerate all border styles:
#  - Count:      none, thin, thick, double
#  - Corners:    sharp/square, rounded, round
#  - Separators: flat, angled, round, blur,
#
# TODO: Find Nix libs
#  - Determine if font with glyphs installed (devicons, powerline fonts, emoji, etc.) on system / home-manager
#  - Determine if font with ligatures installed
#
# TODO: Enumerate Nix options to set
#  - Icons
#  - BorderStyles
#  - Separators (Divider & segment)
#  -
#
# TODO: Create directory for theme definitions
#
{
  imports = [
  ];

  plugins.lspsaga = {
    ui.actionfix  = if emoji    then ""  else "Fix";
    ui.border     = "";  # Accepts same values as `nvim_open_win()`. See `:help nvim_open_win()`
    ui.codeAction = if emoji    then "💡" else "A";
    ui.collapse   = if devicons then "⊟"  else "[-]";
    ui.devicon    =    devicons;
    ui.expand     = if devicons then "⊞"  else "[+]";
    ui.impSign    = if devicons || powerline then "󰳛" else "Impl";
    ui.lines      = ["┗" "┣" "┃" "━" "┏"];
    symbolInWinbar.enable = devicons || powerline;
    symbolInWinbar.separator = "|";
    #       if (chars == "ascii" && style == "angled") then
    #    ">"
    #  else if (chars == "ascii" && style == "square") then
    #    "|"
    #  else if (chars == "ascii" && style == "round") then
    #    ")"
    #  else if (chars == "devicons" && style == "rounded") then
    #    ""
    #  else if (chars == "devicons" && style == "angled") then
    #    ""
    #  else if (chars == "devicons" && style == "square") then
    #    ""
    #  else
    #    ""
  };

}
