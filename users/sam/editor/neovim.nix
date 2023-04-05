{
  self, inputs, system,
  host, user,
  config, lib, pkgs,
  ...
}:
  # --- NixVim ---
  # Configures Neovim via Nix modules
  # https://github.com/pta2002/nixvim
  # https://pta2002.github.io/nixvim
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./editorconfig.nix
  ];

  programs.neovim.withNodeJs = true;
  programs.neovim.withPython3 = true;
  
  programs.neovim.plugins = with pkgs.vimPlugins; [
    { plugin = nvim-treesitter.withAllGrammars; }
  ];

  programs.nixvim.enable = true;

  # --- Options ---
  programs.nixvim.options = {
    cursorline = true;
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    title = true;
  };


  # --- Colors ---
  programs.nixvim.colorschemes.base16 = { 
    enable      = false;
    colorscheme = "material";
  };

  programs.nixvim.colorschemes.gruvbox = {
    enable            = false;
    bold              = true;
    colorColumn       = "bg";
    contrastDark      = "medium";
    contrastLight     = "medium";
    improvedStrings   = true;
    improvedWarnings  = true;
    italicizeComments = false;
    italicizeStrings  = false;
    italics           = true;
    numberColumn      = "bg";
    signColumn        = "bg";
    transparentBg     = true;
    undercurl         = false;
    underline         = false;
  };
  programs.nixvim.colorschemes.nord = {
    enable = false;
    enable_sidebar_background = true;
    borders = true;
    contrast = false;
    cursorline_transparent = true;
    disable_background = true;
    italic = true;
  };
  programs.nixvim.colorschemes.tokyonight = {
    enable = true;
    #dayBrightness = 1;
    dimInactive = true;
    hideInactiveStatusline = true;
    lualineBold = true;
    #onColors = "function(colors) end";
    #onHighlights = "function(highlights, colors) end";
    sidebars = [ "qf" "help" ];
    #style = "storm";
    styles = {
      comments.italic = true;
      floats = "transparent";
    };
    terminalColors = true;
    transparent = true;
  };

  # --- Plugins ---
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nix-develop-nvim
    statix
    vim-addon-nix  # TODO: Handled by LSP?
    vim-nix
    vim-nixhash
    vim2nix
  ];

  home.packages = [ 
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.hackgen-nf-font
    pkgs.inconsolata-nerdfont
    pkgs.maple-mono-NF
    pkgs.meslo-lgs-nf
    pkgs.nerd-font-patcher
    (pkgs.nerdfonts.override { fonts = [
      "Agave"
      "IBMPlexMono"  #"Blex Mono"
      "CascadiaCode" #"Caskaydia Cove"
      "CodeNewRoman"
      "Cousine"
      "DaddyTimeMono"
      "DejaVuSansMono"
      "DroidSansMono"
      "FantasqueSansMono"
      "FiraCode"
      "FiraMono"
      "Gohu"
      "Hack"
      "Hermit"  #"Hurmit"
      "Inconsolata"
      "Iosevka"
      "JetBrainsMono"
      "LiberationMono" #"LiterationMono"
      "Lilex"
      "Meslo" #"MesloLG"
      "Monofur"
      "Monoid"
      "Mononoki"
      "Noto"
      "ProFont"
      "ProggyClean"
      "OpenDyslexic"
      "RobotoMono"
      "ShareTechMono" #"ShureTechMono"
      "SourceCodePro" #"SauceCodePro"
      "SpaceMono"
      "NerdFontsSymbolsOnly"
      "Terminus" #"Terminess"
      "Ubuntu"
      "UbuntuMono"
      "VictorMono"
    ];})
  ];

  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers.bashls.enable = true;
      servers.clangd.enable = true;
      servers.cssls.enable = true;
      servers.dartls.enable = true;
      servers.eslint.enable = true;
      servers.gopls.enable = true;
      servers.html.enable = true;
      servers.jsonls.enable = true;
      servers.lua-ls.enable = true;
      servers.nil_ls.enable = false;
      servers.pylsp.enable = true;
      servers.pylsp.settings.plugins.autopep8.enabled = true;
      servers.pylsp.settings.plugins.flake8.enabled = true;
      servers.rnix-lsp.enable = true;
      servers.rust-analyzer.enable = true;
      servers.tailwindcss.enable = true;
      servers.texlab.enable = true;
      servers.tsserver.enable = true;
      servers.vuels.enable = true;
      servers.zls.enable = true;
    };

    # LSP multi-line diagnostics in-editor
    lsp-lines = {
      enable = true;
      currentLine = false;
    };

    # LSP Completions show entry type
    lspkind = {
      enable = true;
      cmp.enable = true;
      mode = "symbol_text";  #text,text_symbol,symbol_text*,symbol
      preset = "codicons";   #codicons,default
    };

    # LSP enhancements
    lspsaga.enable = true;

    # --- Statusline ---
    lualine = { 
      enable = true;
      alwaysDivideMiddle = false;
      extensions = [ "fzf" ];
      globalstatus = true;
      sectionSeparators = {
        left  = "";
        right = "";
      };
      # TODO: Invert highlight
      componentSeparators = {
        left  = ""; # "";
        right = ""; # ";
      };
    };

    luasnip.enable = true;
    nix.enable = true;
    null-ls.enable = true;
    nvim-autopairs.enable = true;
    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      completion = {
        #autocomplete = "TextChanged";
        #completeopt = "menu,menuone,noselect";
      };
      snippet.expand = "luasnip";
    };

    nvim-colorizer.enable = true;
    nvim-lightbulb = {
      enable = true;
      float.enabled = true;
    };
    nvim-tree = {
      enable = true;
      diagnostics.enable = true;
      modified.enable = true;
    };
    rust-tools.enable = true;
    specs.enable = true;
    telescope = {
      enable = true;
      extensions.frecency.enable = true;
      extensions.fzf-native.enable = true;
    };
    todo-comments.enable = true;
    treesitter = {
      enable = true;
      ensureInstalled = "all";
    };
    treesitter-context.enable = true;
    trouble.enable = true;
    undotree.enable = true;
  };

  # --- Aliases ---
  programs.nixvim.viAlias = true;
  programs.nixvim.vimAlias = true;
}
