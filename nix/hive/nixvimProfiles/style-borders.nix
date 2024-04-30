{ inputs
, config, lib, pkgs
, style
, ...
}:
let

  borderStyle = if config ? styles.borders then config.styles.borders else if style then style else "rounded"; # none | rounded | double | single | solid | shadow | NC
  borderCharSets = {
    rounded = [ "" "" "" "" "" "" "" "" ];
    none = [ "" "" "" "" "" "" "" "" ];
    square = [ "" "" "" "" "" "" "" "" ];
    double = ["╔" "═" "╗" "║" "╝" "═" "╚" "║"];
    border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
    single = ["┌" "─" "┐" "│" "┘" "─" "└" "│"];
    harpoon = ["─" "│" "─" "│" "╭" "╮" "╯" "╰"];
    bqf = ["│" "│" "─" "─" "╭" "╮" "╰" "╯" "█"];
    flaoterm="─│─│┌┐┘└";

    # Windows:  top-left, top,   top-right, right, bottom-right, bottom,    bottom-left,  left
    # Floaterm: top,      right, bottom,    left,  top-left,     top-right, bottom-right, bottom-left
    # Harpoon:  Same as floaterm
  };
  borderChars = borderCharSets."${borderStyle}";
  floatermConvert = borderCharSet: lib.lists.concatString borderCharSet;

  styleLspsaga =
    if borderStyle == "rounded" then borderStyle
    else if borderStyle == "double" then "thick"
    else "thin";
in
{
    colorschemes.nord.borders = borderStyle != "none";
    plugins = {
      clangd-extensions.extensions ={
        memoryUsage.border = borderStyle;
        symbolInfo.border = borderStyle;
      };
      floaterm.borderchars = floatermConvert borderChars;
      gitsigns.previewConfig.border = borderStyle;
      #lspsaga.borderStyle = styleLspsaga;   # Deprecated
      magma-nvim.outputWindowBorders = borderStyle == "rounded";
      noice.presets.lsp_doc_border = borderStyle != "none";
      none-ls.border = borderChars;
      #nvim-bqf = borderChars;
      cmp.window = {
        completion.border = borderChars;
        documentation.border = borderChars;
      };
      nvim-tree.actions.filePopup.openWinConfig.border = borderStyle;
      nvim-tree.view.float.openWinConfig.border = borderStyle;
      #rust-tools.hoverActions.border = [];  # TODO: Append <HighlightGroupName> string to array with char.
      sniprun.borders = if borderStyle == "NC" then "single" else if borderStyle == "rounded" then "single" else if borderStyle == "solid" then "single" else borderStyle;
      #which-key.borders = if borderStyle == "NC" then "single" else if borderStyle == "rounded" then "single" else if borderStyle == "solid" then "single" else borderStyle;
    };
}
