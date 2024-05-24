{ inputs
, config, lib, pkgs
, style      ? "rounded"
, chars      ? "devicons"
, emoji      ? true
, powerline  ? true
, devicons   ? true
, unicode    ? true
, ascii      ? true
, squared    ? true
, rounded    ? false
, singleline ? true
, doubleline ? false
, ...
}:
#
# --- Chars ---
#   Diag:           ⏲               﫠      💡
#   File:  󰈙   󰉋   󰙅   󰜢
#   Math:  󰀫   󰏿   󰊕
# Editor:  ⊟   ⊞      
#  Arrow:  →
# 󰑭   󰜢      󰈇
# 󰆕   󰏘   󰎠      󰌋      
#    󰉿      󰠱      󰳛
#
# Window: <BotL> <ConL> <Vert> <Horz> <TopL>
#   - Square-Single: ┗   ┣   ┃   ━   ┏
#   - Square-Double:
#   -  Round-Single: ┗   ┣   ┃   ━   ┏
#   -  Round-Double:

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

  #plugins.dap = {
  #  signs = {
  #    dapBreakpoint.text = "B";  # TODO: Add dapBreakpoint linehl, numhl, texthl to styles
  #    dapBreakpointCondition.text = "C";
  #    dapBreakpointRejected.text = "R";
  #    dapLogPoint.text = "L";
  #    dapStopped.text = "→";
  #  };
  #  extensions.dap-ui.icons = {
  #    collapsed = "";
  #    current_frame = "";
  #    expanded = "";
  #  };
  #};
  plugins.lspkind = {
    #mode   = if devicons then "symbol" else "text";
    preset = if devicons then "codicons" else "default";
  };

  plugins.lspsaga = {
    ui.actionfix  = if emoji                 then ""  else "Fix";
    ui.codeAction = if emoji                 then "💡" else "A";
    ui.collapse   = if devicons              then "⊟"  else "[-]";
    ui.devicon    =    devicons;
    ui.expand     = if devicons              then "⊞"  else "[+]";
    ui.impSign    = if devicons || powerline then "󰳛"  else "Impl";
    ui.lines      = ["┗" "┣" "┃" "━" "┏"];
    #ui.border     = "";  # Accepts same values as `nvim_open_win()`. See `:help nvim_open_win()`
    symbolInWinbar.enable = devicons || powerline;
    symbolInWinbar.separator = if squared    then "|"  else ")";
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

  #plugins.neogit.signs = {
  #  hunk = null;      # null | list<str>
  #  item = null;      # null | list<str>
  #  section = null;   # null | list<str>
  #};

  plugins.nvim-lightbulb = {
    sign.enabled = true;

    float.text = "💡";
    statusText.text = "💡";
    statusText.textUnavailable = null;  # Text to provide when no actions available.
    virtualText.text = "💡";
  };

  plugins.trouble = {
    icons = devicons;            # Use devicons for filenames.               D=t
    #indentLines = true;         # Show indent guide lines below fold icons. D=t
    useDiagnosticSigns = false;  # Use signs from LSP.                       D=f

    foldOpen          = "";
    foldClosed        = "";

    signs.hint        = "";   #";
    signs.information = "";
    signs.warning     = "";   #";
    #signs.error       = "";
    #signs.other       = "﫠";
  };

  plugins.which-key.icons = {
    breadcrumb = if devicons then "»"    else ">>";
    group      = if devicons then "󰙅 "  else "+ ";
    separator  = if devicons then " ➜  " else " -> ";
  };

}
