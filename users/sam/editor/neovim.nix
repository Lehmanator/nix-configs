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
let
  style = "rounded";
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./editorconfig.nix
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.git.extraConfig.core.editor = "nvim";

  #programs.neovim.withNodeJs = true;
  #programs.neovim.withPython3 = true;

  #programs.neovim.plugins = with pkgs.vimPlugins; [
  #  { plugin = nvim-treesitter.withAllGrammars; }
  #];

  programs.nixvim.enable = true;

  programs.nixvim.highlight = {
    #IndentBlanklineIndent2.ctermfg = "bg";
    #IndentBlanklineIndent1 = { fg = "NONE"; ctermfg = "NONE"; };
    lualine_c_active.bg = "NONE"; lualine_c_inactive.bg = "NONE";
    lualine_x_active.bg = "NONE"; lualine_x_inactive.bg = "NONE";
    lualine_x_normal.bg = "NONE"; #lualine_x_normal.bg = "NONE";
    lualine_c_normal.bg = "NONE"; #lualine_c_normal.bg = "NONE";
    lualine_x_insert.bg = "NONE"; #lualine_x_insert.bg = "NONE";
    lualine_c_insert.bg = "NONE"; #lualine_c_insert.bg = "NONE";
    TabLineFill.bg = "NONE"; TabLineFill.fg = "NONE";
    StatusLine.bg = "NONE";  StatusLineNC.bg = "NONE";
    StatusLine.fg = "NONE";  StatusLineNC.fg = "NONE";
  };
  # --- Options ---
  programs.nixvim.options = {
    # --- Lines ---
    cursorline = true;
    number = true;
    relativenumber = true;

    # --- Indentation ---
    shiftwidth = 2;
    foldlevel = 10;

    # --- Integration ---
    title = true;

    # --- Mouse ---
    mousescroll = "ver:1,hor:2";
    mouse = "a";  # "nv";

  };


  # --- Colors -------------------------
  programs.nixvim.colorschemes = {
    base16 = {
      enable      = false;
      colorscheme = "material";
    };

    gruvbox = {
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

    nord = {
      enable = false;
      enable_sidebar_background = true;
      borders = true;
      contrast = false;
      cursorline_transparent = true;
      disable_background = true;
      italic = true;
    };

    tokyonight = {
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
    pkgs.fd


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

  # --- LaTeX --------------------------
  #home.packages = [
  #  pkgs.texlive.combined.scheme-medium
  #  #pkgs.texlive.combined.scheme-full
  #];
  #programs.nixvim.plugins.vimtex.enable = true;

  # --- Perl ---------------------------
  # Fixes Neovim Perl healthcheck
  #home.packages = [
  #  pkgs.nix-generate-from-cpan
  #  pkgs.perl536Packages.CPAN
  #];

  # --- Git / VCS ----------------------
  # TODO: Compare neogit vs. fugitive

  # Fixes Neovim VCS healthcheck
  #home.packages = [ pkgs.mercurial ];

  programs.nixvim.plugins.gitsigns = {
    enable = true;
    currentLineBlame = true;
    currentLineBlameOpts = {
      virtTextPos = "right_align";      # eol | overlay | right_align
    };
    numhl = false;              # Enable line number highlights
    showDeleted = false;         # Show old version of hunks inline via virtual lines
    signcolumn = true;
    trouble = true;             # Use Trouble instead of QuickFix/LocationList window for setqflist()/setloclist()
    watchGitDir = {
      enable = true;
      followFiles = true;       # Switch to new location after `git mv`
    };
    wordDiff = true;            # Requires `diff_opts.internal = true`
  };
  programs.nixvim.plugins.gitmessenger = {
    enable = false;
    dateFormat = "%c";  # :help strftime()
    floatingWinOps = {
      border = "rounded";
    };
    includeDiff = "none";  # none | current | all
  };
  programs.nixvim.plugins.neogit = {
      enable = true;
      autoRefresh = true;
      #commitPopup.kind = null;
      #disableBuiltinNotifications = null; disableCommitConfirmation = null; disableContextHighlighting = null;
      #disableHint = null;                 disableSigns = null;
      integrations.diffview = true;
      #kind = null;
      #mappings.status = null;
    };
  programs.git.extraConfig.diff.external = false; #extraConfig.diff_opts.internal = true;

  programs.nixvim.plugins = {
    # --- Language Server Protocol -----
    lsp = {
      enable = true;
      keymaps = {
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
      };
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        cssls.enable = true;
        dartls.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        nil_ls.enable = false;
        rnix-lsp.enable = true;
        rust-analyzer.enable = true;
        tailwindcss.enable = true;
        texlab.enable = true;
        tsserver.enable = true;
        vuels.enable = true;
        zls.enable = true;
        pylsp = { enable = true; settings.plugins = { autopep8.enabled = true; flake8.enabled = true; }; };
      };
    };

    # lsp-lines - LSP multi-line diagnostics in-editor
    lsp-lines = { enable = true; currentLine = false; };

    # lspkind.nvim - Entry types for LSP Completions w/ icons
    lspkind = {
      enable = true;
      cmp.enable = true;
      mode = "symbol_text";  #text,text_symbol,symbol_text*,symbol
      preset = "codicons";   #codicons,default
    };

    # lspsaga.nvim - LSP enhancements
    lspsaga = {
      enable = true;
      borderStyle = "rounded";
    };

    # inc-rename - Incremental previewing LSP renaming
    inc-rename.enable = true;

    # --- Statuslines ------------------
    barbar = {
      enable = false;
      animation = true;
      autoHide = false;
      clickable = true;
      excludeFileNames = [];
      excludeFileTypes = [];
      extraOptions = {};
      hide.alternate = true;
      hide.current = false;
      hide.extensions = false;
      highlightAlternate = false;
      highlightInactiveFileIcons = false;
      highlightVisible = true;
      icons = {
        current = {
          pinned.separator = { left = "▎"; right = ""; };  # TODO: Conditionally use rounded
          separator = { left = ""; right = ""; };  # TODO: Conditionally use rounded
        };
        diagnostics = {
          error.enable = true;
          warn.enable = false;
        };
      };
    };
    lualine = {
      enable = true;
      alwaysDivideMiddle = true;
      extensions = [ "fzf" ];
      globalstatus = true;
      sectionSeparators = {
        left  = "";
        right = "";
      };
      # TODO: Invert highlight
      componentSeparators = {
        left  = ""; # "";
        right = ""; # ";
      };
      tabline = {  # Top of editor
        lualine_a = [ { name = "hostname"; separator = { left = ""; right = ""; }; } ];
        lualine_b = [ "branch" "diff" ];
        lualine_x = [ {name="tabs"; extraConfig={use_mode_colors=true;};} ];
        lualine_z = [ "diagnostics" ];
      };
      winbar = {  # Top of splits
        lualine_a = [ { name="mode"; separator = { left = ""; right = ""; }; } ];
        lualine_b = [ "diff" ];
        lualine_c = [ {name="windows"; extraConfig={use_mode_colors=true;}; } ];
        lualine_x = [ "branch" "diff" ];
        lualine_y = [ "searchCount" ];
        lualine_z = [ "selectionCount" ];
      };
      sections = {
        lualine_a = [
          { name = "mode"; separator = { left = ""; right = ""; }; }
        ];
        lualine_b = [
          #{ name = "branch";
          #}
          "branch"
          "diff"
        ];
        lualine_c = [
          { name="buffers"; extraConfig={use_mode_colors=true; mode=0;}; }
          #{ name="filetype"; extraConfig={colored=true; icon_only=true; icon.align="left";};}
          #{ name="filename"; extraConfig={file_status=true; newfile_status=true; shorting_target=45; path = 4;
          #  symbols={modified="~"; readonly="!"; unnamed="?"; newFile="+";};};
          #}
          #"fileformat"
          #{ name = "fileformat"; extraConfig={symbols={unix=""; dos=""; mac="";}; icon.align="left";};}
        ];
        lualine_x = [
          #{ name="tabs";
          #  separator = { left = ""; right = ""; };
          #  extraConfig={mode=2; use_mode_colors=true; tabs_color={active="lualine_a_normal"; inactive="lualine_b_normal";};}; }
          "diagnostics"
          #{ name = "diagnostics";
          #}
        ];
        lualine_y = [
          "searchcount"
          "progress"
          #{ name = "progress";
          #}
        ];
        lualine_z = [
          { name = "location";
            separator = { left = ""; right = ""; };
          }
        ];
      };
    };
    tagbar = {
      enable = false;
      extraConfig = { show_tag_count = true; };
    };

    # --- Snippets ---------------------
    luasnip = {
      enable = true;
      fromVscode = [
        #{ paths = "${config.xdg.dataHome}/vscode/snippets"; }
        #{ paths = "${config.home.homeDirectory}/.var/app/<FlatpakAppID>/.../snippets"; }
        #{ paths = "${pkgs.vscodium}/.../snippets"; }
      ];
    };

    # --- Jupyter Notebooks ------------
    # FIX: Missing Python package `kaleido` which is not in `nixpkgs`
    #magma-nvim = { enable = true; automaticallyOpenOutput = true; }; # Call :MagmaShowOutput on cell run

    # --- File Tree --------------------
    # File Tree plugin  # TODO: Compare:
    # - neo-tree   - nerdtree  - dirbuf.nvim  - iir.nvim
    # - nvim-tree  - nnn.nvim  - telescope-file-browser

    # nvim-tree
    nvim-tree = {
      enable = false;
      diagnostics.enable = true;
      modified.enable = true;
    };

    neo-tree = {
      enable = true;

      addBlankLineAtTop = false;
      autoCleanAfterSessionRestore = false;  # Auto clean up broken neotree buffers saved in sessions
      buffers = {
        bindToCwd = true;
        followCurrentFile = true;
        groupEmptyDirs = true;
        window.mappings = { "<bs" = "navigate_up"; "." = "set_root"; bd = "buffer_delete"; };
      };
      closeFloatsOnEscapeKey = true;     # Close floating window UI on <ESC> press
      closeIfLastWindow = true;          # Close Neovim if Neo-Tree is last window (*false)
      defaultComponentConfigs.diagnostics.symbols = {
        error = "✘"; warn = ""; info = ""; hint = "";
      }; # vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
      filesystem = {
        filteredItems.forceVisibleInEmptyFolder = true;                         # Show hidden files in empty dir (*false)
        filteredItems.hideDotfiles = false;                                     # Hide hidden files              (*true)
        findArgs = { fd = [ "--exclude" ".git" "--exclude" "node_modules" ]; }; # Args to pass find commands     (*null)
        useLibuvFileWatcher = true;          # Detect changes w/ OS-level file watchers, not nvim autocmd events (*false)
        window.mappings = {           "#"="fuzzy_sorter";    "."="set_root";      "[g"="prev_git_modified";
          D="fuzzy_finder_directory"; "/"="fuzzy_finder"; "<bs>"="navigate_up";   "]g"="next_git_modified";
          f="filter_on_submit";   "<C-x>"="clear_filter";      H="toggle_hidden";                            };
      };
      gitStatus.window.mappings = { A = "git_add_all";      ga = "git_add_file"; gc = "git_commit";
        gu = "git_unstage_file";   gr = "git_revert_file";  gp = "git_push";     gg = "git_commit_and_push"; };
      popupBorderStyle = "NC";   # (*NC | double | none | rounded | shallow | single | solid)
      useDefaultMappings = true; # (*true)
      window = {
        autoExpandWidth = false;  # Expand window width when file exceeds window width. Incompat: position='float' (*false)
        height = 15;              # (*15)
        insertAs = "child";       # How to insert files in tree when cursor on dir  (*child | sibling)
        # Some commands take optional config options, see :h neo-tree-mappings
        mappings = { "<2-LeftMouse>"="open";               "<cr>"="open";         "<"="prev_source";
          S="open_split";          w="open_with_window_picker"; q="close_window"; ">"="next_source";
          s="open_vsplit";         t="open_tabnew";             C="close_node";     z="close_all_nodes";
          l="focus_preview"; "<esc>"="revert_preview";          R="refresh";        e="toggle_auto_expand_width";
          c="copy";                m="move";                    r="rename";         d="delete";
          y="copy_to_clipboard";   x="cut_to_clipboard";        p="paste_from_clipboard";
          A="add_directory";     "?"="show_help";
          "<space>"={command="toggle_node";    config.nowait=true;     }; # `nowait`: Use existing combos w/ begin char
                  P={command="toggle_preview"; config.use_float=true;  };
                  a={command="add";            config.show_path="none";}; # show_path = "none|relative|absolute"
        };
        popup = {position="80%"; size.height="80%"; size.width="50%";};
        position = "left";  # left | right | top | bottom | float | current
        sameLevel = false;  # Create/paste/move files/dirs on same level as dir under cursor (vs w/i dir under cursor)
        width = 40;
      };
    };

    # --- Neorg ------------------------
    # Organization file format: .norg
    # https://github.com/nvim-neorg/neorg
    neorg = {
      enable = true;
      extraOptions = {};
      lazyLoading = true;
      modules = {
        # --- Default Modules ---
        #"core.defaults".config.disable = [];
        #"core.clipboard.code-blocks" = {}; "core.looking-glass" = {}; "core.itero" = {};
        #"core.keybinds".config.default_keybinds = true; # TODO: Set `localleader` for `.norg` files
        #"core.norg.esupports.indent".config = {};
        #"core.norg.esupports.hop".config = { external_filetypes = []; };
        #"core.norg.news"={}; "core.norg.qol.toc"={}; "core.norg.qol.todo_items"={}; "core.promo"={}; "core.tangle"={}; "core.upgrade" = {};
        "core.norg.esupports.metagen".config = { type = "auto"; update_date = true; };
        "core.norg.journal".config = {
          journal_folder = "${config.home.homeDirectory}/Notes/Journal";
          strategy = "flat";
          #workspace = "journal";
        };

        # --- Other Modules ---
        "core.norg.dirman".config.workspaces = { # Manage directories of .norg files
          work="${config.home.homeDirectory}/Notes/Work";
          home="${config.home.homeDirectory}/Notes/Home";
          #journal="${config.home.homeDirectory}/Notes/Journal";
        };
        "core.export.markdown".config.extensions = "all";  # Export .norg docs to other supported filetypes
        "core.norg.completion".config.engine = "nvim-cmp"; # TODO: Set `sources={ {name="neorg"},},` as source in `nvim-cmp`
        "core.presenter".config.zen_mode = "zen-mode";     # (zen-mode | truezen)
        "core.export"={}; "core.norg.concealer"={};

        # --- Developer Modules ---
        # core: autocommands, clipboard, defaults, fs, highlights, mode, scanner, storage, syntax
        # core.integrations: nvim-cmp, nvim-compe, treesitter, truezen, zen_mode
        # core.neorgcmd: ., commands.module.list, commands.module.load, commands.return
        # core.norg.dirman.utils core.queries.native
        "core.clipboard"={}; "core.scanner"={}; "core.syntax"={};

        # --- Community Modules ---
        # https://github.com/nvim-neorg/neorg-telescope

      };
    };

    # --- Netman -----------------------
    # Access network resources in Neovim
    netman = { enable = false; neoTreeIntegration = true; };

    # --- Noice.nvim -------------------
    # Alternate UI for Neovim. Completely replaces cmdline, messages, popupmenu
    #noice = {
    #  enable = true;
    #  popupmenu.backend = "nui";  # (nui | cmp)
    #  notify = { enable = true; stages = "slide"; }; # stages: fade_in_slide_out | fade | slide | static
    #};

    # --- null-ls ----------------------
    # Integrate external sources with native nvim LSP
    null-ls = {
      enable = true;
      border = "rounded";  # none | single | double | rounded | solid | shadow
      #diagnosticConfig = {};
      #shouldAttach = "";  # User-defined function(buffer_number) that controls whether to enable null-ls for buffer.
      sources = {
        code_actions = { gitsigns.enable = true; shellcheck.enable = true; };
        diagnostics = { cppcheck.enable = true; flake8.enable = true; gitlint.enable = true;  shellcheck.enable = true; };
        formatting = { alejandra.enable = true; black.enable = true; cbfmt.enable = true;
          fnlfmt.enable = true; fourmolu.enable = true; nixfmt.enable = true; phpcbf.enable = true;
          prettier.enable = true; shfmt.enable = true; stylua.enable = true; taplo.enable = true; };
      };
    };

    # --- Language Tools ---------------
    # Nix language syntax
    nix.enable = true;

    # PlantUML syntax for UML diagrams
    plantuml-syntax.enable = true;

    zig.enable = true;

    # --- Pairs ------------------------
    # Insert, remove, highlight syntax pairs
    nvim-autopairs = {
      enable = false;
      checkTs = true;
      disableInMacro = false;
      mapCW = true;  # Delete pair w/ CTRL-W
    };
    surround.enable = false;
    endwise.enable = false;
    vim-matchup = {
      enable = false;
      enableSurround = true;
      enableTransmute = true;
      textObj.linewiseOperators = [ "d" "y" ];  # Modify set of operators which may operate line-wise
      treesitterIntegration.enable = true;
      treesitterIntegration.includeMatchWords = true;  # Include vim regex matches for symbols. e.g. /* */ comments in C++ which are not supported by treesitter matching
    };
    emmet = {
      enable = false;
      leader = null;
      mode = null;     # i | n | v | a
      settings = null;
    };


    # indent-blankline.vim - Show indentation guides
    indent-blankline = {
      enable = true;
      buftypeExclude = ["terminal" "nofile" "quickfix" "prompt"];
      #contextPatterns = [ "class" "^func" "method" "^if" "while" "for" "with" "try" "except" "arguments" "argument_list" "object" "dictionary" "element" "table" "tuple" "do_block" ];
      filetypeExclude = ["lspinfo" "packer" "checkhealth" "help" "man"];
      spaceCharBlankline = " ";
      showCurrentContext = true;
      showCurrentContextStart = true;  # Applies highlight group `hl-IndentBlanklineContextStart` to first line in current context.
      showCurrentContextStartOnCurrentLine = true;  # Apply ^^ even when cursor on same line
      #showFirstIndentLevel = false;
      #showTrailingBlanklineIndent = false;
      #char = "│"; contextChar = "";
      useTreesitter = true;
      useTreesitterScope = true;
      #charHighlightList = [ "IndentBlankLineIndent1" "IndentBlankLineIndent2" "IndentBlankLineIndent2" "IndentBlankLineIndent2" ];
      #spaceCharHighlightList = [ "IndentBlankLineIndent1" "IndentBlankLineIndent2" "IndentBlankLineIndent2" "IndentBlankLineIndent2" ];
    };

    # Tab indents to proper level based on syntax
    intellitab.enable = true;

    # --- QuickFix ---------------------
    # Better QuickFix window with FZF and previews
    nvim-bqf = {
      enable = true;
      autoResizeHeight = true;
      extraOptions = {};
      magicWindow = true;
      preview = { autoPreview = true; bufLabel = true; showTitle = true; winHeight = 15; winVheight = 15; wrap = false; }; #borderChars = {};
    };

    # --- Completion -------------------
    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      completion = {
        #autocomplete = [ "TextChanged" ];
        completeopt = "menu,menuone,noselect";
        keywordLength = 1;
      };
      #confirmation.getCommitCharacters = "function(commit_characters return commit_characters end)";
      experimental = { ghost_text = true; };
      formatting.fields = ["kind" "abbr" "menu"];
      mappingPresets = ["insert" "cmdline"];
      preselect = "Item";                      # Item | None
      snippet.expand = "luasnip";              # luasnip | snippy | ultisnips | vsnip | function()
      window.completion = {
        colOffset = 0;
        scrollbar = true; scrolloff = 0;
        sidePadding = 1;
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None";
      }; #border = ["" "" "" "" "" "" "" ""];
      window.documentation = { winhighlight = "FloatBorder:NormalFloat"; }; #border = ["" "" "" "" "" "" "" ""];
    };
    cmp-buffer.enable = true;
    cmp-calc.enable = true;
    cmp-clippy.enable = true;
    cmp-cmdline.enable = true;
    cmp-cmdline-history.enable = true;
    cmp-conventionalcommits.enable = true;
    cmp-copilot.enable = true;
    cmp-dap.enable = true;
    cmp-dictionary.enable = true;
    cmp-digraphs.enable = true;
    cmp-emoji.enable = true;
    cmp-fish.enable = config.programs.fish.enable;
    cmp-fuzzy-buffer.enable = true;
    cmp-fuzzy-path.enable = true;
    cmp-git.enable = true;
    cmp-greek.enable = true;
    cmp-latex-symbols.enable = true;
    cmp-look.enable = true;
    cmp-npm.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-document-symbol.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-nvim-lua.enable = true;
    cmp-nvim-ultisnips.enable = false;
    cmp-omni.enable = true;
    cmp-pandoc-nvim.enable = true;
    cmp-pandoc-references.enable = true;
    cmp-path.enable = true;
    cmp-rg.enable = true;
    cmp-snippy.enable = false;
    cmp-spell.enable = false;
    cmp-tabnine.enable = false;
    cmp-tabnine.extraOptions = {};
    cmp-tmux.enable = false;
    cmp-treesitter.enable = true;
    cmp-vim-lsp.enable = false;
    cmp-vimwiki-tags.enable = false;
    cmp-vsnip.enable = false;
    cmp-zsh.enable = true;
    cmp_luasnip.enable = true;

    nvim-jdtls.enable = false;  # Java LSP configuration
    #nvim-jdtls.data = "/path/to/your/workspace";


    # --- Highlighting -----------------
    # Highlight marks on backtick press
    mark-radar.enable = true;      # TODO: Match highlight group `highlightGroup = "RadarMark"` w/ theme accent

    # Highlight colors (names, rgb, hex, etc.)
    #nvim-colorizer.enable = true;

    # Show cursor jumps with highlights
    specs = {
      enable = true;
      min_jump = 3;
      width = 5;
    };

    # Highlight comments with TODO
    todo-comments.enable = true;


    # --- Startup ----------------------
    dashboard = {
      enable = true;
      #header = ''
      #'';
      #center = {
      #  <name> = { action = ""; desc = ""; icon = ""; shortcut = ""; };
      #};
      #footer = ''
      #'';
      #hideStatusline = false;
      #hideTabline = false;
      #preview = { command = ""; file = ""; height = 40; width = 40; };
      #sessionDirectory = "";
    };
    startify.enable = false;
    lastplace.enable = true;


    # --- Code Actions -----------------
    nvim-lightbulb = {
      enable = true;
      float.enabled = true;
      autocmd.enabled = true;
      statusText.enabled = true;
      virtualText.enabled = true;
    };

    rust-tools = {
      enable = true;
      crateGraph = {
        enabledGraphvizBackends = ["dot" "jpg" "json" "pdf" "plain-ext" "png" "svg" "webp" "x11"];
        backend = "svg";
      };
      server.cargo.features = "all";
    };
    crates-nvim.enable = true;

    # --- Telescope.nvim ---------------
    telescope = {
      enable = true;
      extensions = {
        frecency.enable = true;
        fzf-native.enable = true;
        #fzy-native.enable = true;
        media_files.enable = true;
        project-nvim.enable = true;
      };
      #defaults = {};
      #extraOptions = {};
      #highlightTheme = nulll;
      #keymaps = { "<C-p>" = "git_files"; "<leader>fg" = "live_grep"; };
    };


    # --- Treesitter -------------------
    treesitter = {
      enable = true;
      ensureInstalled = "all";
      folding = true;
      incrementalSelection = {
        enable = true;
        keymaps = { initSelection = "gnn"; nodeDecremental = "grm"; nodeIncremental = "grn"; scopeIncremental = "grc"; };
      };
      indent = true;
      nixGrammars = true;
    };
    treesitter-context.enable = true;
    treesitter-playground.enable = true;
    treesitter-rainbow.enable = false;
    treesitter-refactor = {
      enable = true;
      highlightCurrentScope.enable = false;
      highlightDefinitions.enable = true;
      navigation.enable = true;
      smartRename.enable = true;
    };

    # --- UI Packages ------------------
    floaterm = {
      enable = true;
      autoclose = 1;
      autohide = 1;
      autoinsert = true;
      borderchars = "─│─│┌┐┘└";
      giteditor = true;
      height = 0.6;
      #keymaps = { first=""; hide=""; kill=""; last=""; new=""; next=""; prev=""; show=""; toggle=""; };
      opener = "split";   # edit | split | vsplit | tabe | drop
      position = "auto";  # wintype=split: leftabove | aboveleft | rightbelow | belowright | topleft | botright
                              # wintype=float: top | bottom | left | right | topleft | topright | bottomleft | bottomright | center | auto (at cursor position)
      rootmarkers = [ ".project" ".git" ".hg" ".svn" ".root" "flake.nix" ".github" ];
      wintype = "float";
    };
    # trouble.nvim - Pretty list for showing:
    # - diagnostics   - references      - telescope results
    # - quickfix      - location lists
    trouble.enable = true;

    undotree.enable = true;

    # --- System Integration -----------
    nvim-osc52 = {
      enable = true;
      keymaps = { enable = true; }; #copy="+<+leader>y"
    };

    # --- Projects ---------------------
    project-nvim.enable = true;

    # --- Runners ----------------------
    sniprun = {
      enable = true;
      display = ["VirtualTextOk" "LongTempFloatingWindowOk" "NvimNotifyOk" "TerminalErr" ];
      #liveModeToggle = "on";
      #replEnable = [];
    };

    # --- Comments ---------------------
    comment-nvim = {
      enable = true;
      mappings = { basic = true; extended = true; extra = true; };
      padding = false;
      #sticky = false;
    };
    commentary.enable = false;

    # --- Keymaps ----------------------
    easyescape.enable = true;

    # --- Editorconfig ---
    editorconfig.enable = true;
  };


  # --- Aliases ---
  programs.nixvim.viAlias  = true;
  programs.nixvim.vimAlias = true;
}
