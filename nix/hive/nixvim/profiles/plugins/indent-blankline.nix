{
  config,
  lib,
  pkgs,
  ...
}: {
  plugins.indent-blankline = {
    # indent-blankline.vim - Show indentation guides
    enable = lib.mkDefault true;
    exclude = {
      buftypes = ["terminal" "nofile" "quickfix" "prompt"];
      filetypes = [
        "lspinfo"
        "packer"
        "checkhealth"
        "help"
        "man"
        "gitcommit"
        "TelescopePrompt"
        "TelescopeResults"
        "''"
      ];
    };

    #indent = {
    #  highlight = "|hl-IblIndent|";
    #  priority = 1;
    #  smartIndentCap = true;
    #  tabChar = "list";
    #};

    scope = {
      enabled = true;
      #char = "indent.char";
      #highlight = "|hl-IblScope|";
      injectedLanguages = true;
      priority = 1024;

      # Show underline on 1st & last lines of scope starting/ending @ exact start/end of scope,
      #   even if right of indent guide.
      #  Default: false
      showExactScope = true;

      showEnd = true;

      # Applies highlight group `hl-IndentBlanklineContextStart` to first line in current context.
      showStart = true;

      exclude.language = []; # List of treesitter languages for which scope is disabled. (List<str>)
      exclude.nodeType = {
        "*" = ["source_file" "program"]; # Wildcard: all langs
        lua = ["chunk"];
        python = ["module"];
      };
      include.nodeType = {};
    };

    viewportBuffer.max = 500;
    viewportBuffer.min = 30;
    #whitespace.highlight = "hl-IblWhitespace";
    whitespace.removeBlanklineTrail = true;

    #contextPatterns = [ "class" "^func" "method"
    #  "^if" "while" "for" "with" "try" "except" "arguments"
    #  "argument_list" "object" "dictionary" "element"
    #  "table" "tuple" "do_block" ];

    #spaceCharBlankline = " ";
    #char = "│";
    #contextChar = "";
    #charHighlightList = [      "IndentBlankLineIndent1"
    #  "IndentBlankLineIndent2" "IndentBlankLineIndent2"
    #  "IndentBlankLineIndent2" ];
    #spaceCharHighlightList = [ "IndentBlankLineIndent1"
    #  "IndentBlankLineIndent2" "IndentBlankLineIndent2"
    #  "IndentBlankLineIndent2" ];
  };
}
