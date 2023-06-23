{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.plugins.indent-blankline = {
    # indent-blankline.vim - Show indentation guides
      enable = lib.mkDefault true;
      buftypeExclude = [ "terminal" "nofile" "quickfix" "prompt" ];
      #contextPatterns = [ "class" "^func" "method"
      #  "^if" "while" "for" "with" "try" "except" "arguments"
      #  "argument_list" "object" "dictionary" "element"
      #  "table" "tuple" "do_block" ];

      filetypeExclude = [ "lspinfo" "packer" "checkhealth"
                          "help"    "man"                  ];

      spaceCharBlankline = " ";
      showCurrentContext = true;
      showCurrentContextStart = true; # Applies highlight group `hl-IndentBlanklineContextStart` to first line in current context.
      showCurrentContextStartOnCurrentLine = true; # Apply ^^ even when cursor on same line
      #showFirstIndentLevel = false;
      #showTrailingBlanklineIndent = false;
      #char = "│";
      #contextChar = "";
      #charHighlightList = [      "IndentBlankLineIndent1"
      #  "IndentBlankLineIndent2" "IndentBlankLineIndent2"
      #  "IndentBlankLineIndent2" ];
      #spaceCharHighlightList = [ "IndentBlankLineIndent1"
      #  "IndentBlankLineIndent2" "IndentBlankLineIndent2"
      #  "IndentBlankLineIndent2" ];

      useTreesitter = config.programs.nixvim.plugins.treesitter.enable;
      useTreesitterScope = config.programs.nixvim.plugins.treesitter.enable;

  };
}
