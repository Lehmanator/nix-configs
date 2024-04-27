{config, ...}: {
  # --- Treesitter -------------------
  programs.nixvim.plugins = {
    cmp-treesitter.enable = true; # Make nvim-cmp completion use ts source
    nvim-autopairs.checkTs = true; # Make autopair matching use treesitter

    treesitter = {
      enable = true;
      folding = true;
      indent = true;
      nixGrammars = true; # Install grammars with Nix
      nixvimInjections =
        true; # Nixvim-specific injections (Lua highlight in extraConfigLua)
      incrementalSelection.enable = true;

      #ensureInstalled = "all";  # "all" | ["<language>"...]
      #customCaptures = {};      # Custom capture group highlighting.
      #disabledLanguages = [];   # List of languages to disable
      #grammarPackages = [];     # Grammar packages to install
      #ignoreInstall = [];       # List<str>. List of parsers to ignore installing for all
      #languageRegister = {      # Wrapping of `vim.treesitter.language.register` function. Registers parsers to filetype(s).
      #                          #     Keys = parser names
      #};                        #   Values = one/several filetypes.
      #moduleConfig = {          # Configuration for extra modules. Shouldnt be used directly
      #};
    };

    treesitter-context = {
      enable = true;
      #exactPatterns = {};      # Treat the corresponding entry in patterns as an exact match. Attrset of booleans
      #lineNumbers = false;
      maxLines = 3; # Num lines window spans. null = no limit
      minWindowHeight = 40; # Min win height to show context. null=no-limit
      mode = "cursor"; # cursor|topline|<raw_lua>
      #patterns = {};           # Patterns to use for context delimitation. 'default' matches all filetypes. Options: attrs<str>
      #separator = "─";
      #trimScope = "outer";     # Which context lines to discard if `maxLines` exceeded. Options: outer | inner
    };

    #treesitter-playground = {
    #  enable = true;           # Enable nvim-treesitter-playground
    #  #disabledLanguages = []; # List of languages where this module should be disabled.
    #  #package = pkgs.vimPlugins.playground; # ???
    #  #persistQueries = null;  # Whether query persists across vim sessions. Options: null | <bool>
    #  #updateTime = 25;        # Debounced time for highlighting nodes in the playground from source code
    #};

    treesitter-refactor = {
      enable = true;
      highlightCurrentScope.enable = true;
      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = true;
      };
      navigation.enable = true;
      smartRename.enable = true;
      #navigation.keymaps={};
    };
    treesitter-textobjects = {
      enable = true;
      lspInterop = {
        enable = true;
        border = "rounded";
        floatingPreviewOpts = {};
        peekDefinitionCode = {};
      };
      move.enable = true; # {...};
      select = {
        enable = true;
        includeSurroundingWhitespace = false;
        keymaps = {};
        lookahead = true;
        selectionModes = {};
      };
      swap = {enable = true;};
    };

    rainbow-delimiters = {
      enable = false;
      #package = pkgs.vimPlugins.nvim-ts-rainbow2;
      #disable = [];                                                             # Language list to disable plugin for.
      #hlgroups = [       "TSRainbowRed"   "TSRainbowYellow" "TSRainbowBlue"     # List of highlight groups to apply.
      # "TSRainbowOrange" "TSRainbowGreen" "TSRainbowViolet" "TSRainbowCyan" ];  #   Options: null | ["<hlGroup>"...]
      #strategy = "require('ts-rainbow').strategy.global";                       # Query for finding delimiters. Direct lua code in str
      #extraOptions = {                                                          # Attrs added to the setup function's table parameter
      #};                                                                        #   (Can override other attributes set by nixvim)
    };

    # Note: Unnecessary because functionality now standard in Neovim.
    #treesitter-playground = {
    #  enable = true;           # Enable nvim-treesitter-playground
    #  #disabledLanguages = []; # List of languages where this module should be disabled.
    #  #package = pkgs.vimPlugins.playground; # ???
    #  #persistQueries = null;  # Whether query persists across vim sessions. Options: null | <bool>
    #  #updateTime = 25;        # Debounced time for highlighting nodes in the playground from source code
    #};
  };

  programs.nixvim.highlight = {
    TreesitterContextBottom = {
      underline = true;
      #link = "TreesitterContextLineNumberBottom";
      #fg = "black";
      blend = 25;
      #bg = "black";
      #guisp = "Grey";
    };
    TreesitterContextLineNumberBottom = {
      underline = true;
      blend = 25;
      #bg = "black";
      #guisp = "Grey";
      link = "TreesitterContextBottom";
    };
    TreesitterContextLineNumber = {
      blend = 25;
      #bg = "black";
      link = "TreesitterContext";
    };
    TreesitterContext = {
      blend = 25;
      bg = "#282828";
    };
  };
}
