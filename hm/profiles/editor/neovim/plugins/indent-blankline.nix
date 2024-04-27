{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.indent-blankline = {
    # indent-blankline.vim - Show indentation guides
    enable = lib.mkDefault true;
    settings = {
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
        injected_languages = true;
        priority = 1024;

        # Show underline on 1st & last lines of scope starting/ending @ exact start/end of scope,
        #   even if right of indent guide.
        #  Default: false
        show_exact_scope = true;

        show_end = true;

        # Applies highlight group `hl-IndentBlanklineContextStart` to first line in current context.
        show_start = true;

        exclude.language = []; # List of treesitter languages for which scope is disabled. (List<str>)
        exclude.node_type = {
          "*" = ["source_file" "program"]; # Wildcard: all langs
          lua = ["chunk"];
          python = ["module"];
        };
        include.nodeType = {};
      };

      viewport_buffer = {
        max = 500;
        min = 30;
      };
      #whitespace.highlight = "hl-IblWhitespace";
      whitespace.remove_blankline_trail = true;

      #context_patterns = [ "class" "^func" "method"
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
  };
}
