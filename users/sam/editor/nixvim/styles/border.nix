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
    floaterm.borderchars = "─│─│┌┐┘└";

    nvim-cmp = {
      window.completion.border = borderChars;
    };
    #null-ls.border = "";   # See: `:help nvim_open_win()`
  };
}
