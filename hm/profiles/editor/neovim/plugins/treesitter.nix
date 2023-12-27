{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  # --- Treesitter -------------------
  programs.nixvim.plugins = {
    cmp-treesitter.enable = true; # Make nvim-cmp completion use treesitter source
    nvim-autopairs.checkTs = true; # Make autopair matching use treesitter

    treesitter = {
      enable = true;
      folding = true;
      indent = true;
      nixGrammars = true; # Install grammars with Nix
      nixvimInjections = true; # Enable Nixvim-specific injections (like Lua highlighting in extraConfigLua)
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
      #maxLines = null;         # How many lines the window should span.          null = no limit. Options: null | <int> > 0
      #maxWindowHeight = null;  # Minimum editor window height to enable context. null = no limit. Options: null | <int> > 0
      #patterns = {};           # Patterns to use for context delimitation. 'default' matches all filetypes. Options: attrs<str>
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
      highlightDefinitions.enable = true;
      highlightDefinitions.clearOnCursorMove = true;
      navigation.enable = true;
      smartRename.enable = true;
      #navigation.keymaps={};
    };
    treesitter-textobjects = {
      enable = true;
      lspInterop = {enable=true; border="rounded"; floatingPreviewOpts={}; peekDefinitionCode={};};
      move.enable=true; # {...};
      select={enable=true; includeSurroundingWhitespace=false; keymaps={}; lookahead=true; selectionModes={};};
      swap={enable=true;};
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
}
