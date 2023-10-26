{ inputs, self
, config, lib, pkgs
, style ? "rounded"
, ...
}:
let
  borderCharSets = {
    rounded = [ "" "" "" "" "" "" "" "" ];
    none = [ "" "" "" "" "" "" "" "" ];
    square = [ "" "" "" "" "" "" "" "" ];
    double=["╔" "═" "╗" "║" "╝" "═" "╚" "║"];
    border=["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
    single=["┌" "─" "┐" "│" "┘" "─" "└" "│"];
    #flaoterm="─│─│┌┐┘└";
  };
  borderChars = borderCharSets."${style}";
in
{
  imports = [
  ];

  programs.nixvim.plugins = {
    #dap.extensions.dap-ui.floating.border = "single";  # Accepts same border values as nvim_open_win()

    floaterm.borderchars = "─│─│┌┐┘└";

    nvim-cmp = {
      window.completion.border = borderChars;
    };
    #none-ls.border = "";   # See: `:help nvim_open_win()`
  };
}
