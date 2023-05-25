{ self
, inputs
, system
, host
, user
, config
, lib
, pkgs
, uiShape ? "rounded"
, ...
}:

# --- NixVim ---
# Configures Neovim via Nix modules
# https://github.com/pta2002/nixvim
# https://pta2002.github.io/nixvim

# TODO: lib.exportNeovimKeybinds <neovimConfig>
# TODO: lib.exportNixvimKeybinds <nixvimConfig>
# TODO: lib.exportVimKeybinds       <vimConfig>
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./editorconfig.nix
    ../../../configs/nixvim/common/colorscheme.nix
    ../../../configs/nixvim/common/statusline.nix
    ../../../configs/nixvim/common/plugins
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = [
    pkgs.fd
  ];

  programs.git.extraConfig.core.editor = "nvim"; # TODO: Replace with pkgs.neovim ?

  #programs.neovim.withNodeJs = true;
  #programs.neovim.withPython3 = true;

  #programs.neovim.plugins = with pkgs.vimPlugins; [
  #  { plugin = nvim-treesitter.withAllGrammars; }
  #];


  # --- Editorconfig ---
  editorconfig.enable = true;

  programs.nixvim.enable = true;

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
    mouse = "a"; # "nv";

  };


  # --- Colors -------------------------

  # --- Plugins ---
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nix-develop-nvim
    statix
    vim-addon-nix # TODO: Handled by LSP?
    vim-nix
    vim-nixhash
    vim2nix
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
      virtTextPos = "eol"; # eol | overlay | right_align
    };
    numhl = false; # Enable line number highlights
    showDeleted = false; # Show old version of hunks inline via virtual lines
    signcolumn = true;
    trouble = true; # Use Trouble instead of QuickFix/LocationList window for setqflist()/setloclist()
    watchGitDir = {
      enable = true;
      followFiles = true; # Switch to new location after `git mv`
    };
    wordDiff = true; # Requires `diff_opts.internal = true`
  };
  programs.nixvim.plugins.gitmessenger = {
    enable = false;
    dateFormat = "%c"; # :help strftime()
    floatingWinOps = {
      border = "rounded";
    };
    includeDiff = "none"; # none | current | all
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

    # Integrate browser textboxes with Neovim config
    firenvim.enable = true;

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
          ca = "code_action";
          ff = "format";
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
        nil_ls.enable = true;
        rnix-lsp.enable = false;
        rust-analyzer.enable = true;
        tailwindcss.enable = true;
        terraformls.enable = true;
        texlab.enable = true;
        tsserver.enable = true;
        vuels.enable = true;
        zls.enable = true;
        pylsp = { enable = true; settings.plugins = { autopep8.enabled = true; flake8.enabled = true; }; };
      };
    };

    # lsp-lines - LSP multi-line diagnostics in-editor
    lsp-lines = { enable = true; currentLine = false; };
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
    };

    # lspkind.nvim - Entry types for LSP Completions w/ icons
    lspkind = {
      enable = true;
      cmp.enable = true;
      mode = "symbol"; #text,text_symbol,symbol_text*,symbol
      preset = "codicons"; #codicons,default
    };

    # lspsaga.nvim - LSP enhancements
    # TODO: Compatible with Noice?
    lspsaga = {
      enable = true;
      borderStyle = "rounded";
    };

    # inc-rename - Incremental previewing LSP renaming
    inc-rename.enable = true;

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
      # TODO: Conditionally set NerdFonts icons in Neovim if we have a supported font installed.
    };

    neo-tree = {
      enable = true;

      addBlankLineAtTop = false;
      autoCleanAfterSessionRestore = false; # Auto clean up broken neotree buffers saved in sessions
      buffers = {
        bindToCwd = true;
        followCurrentFile = true;
        groupEmptyDirs = true;
        window.mappings = { "<bs" = "navigate_up"; "." = "set_root"; bd = "buffer_delete"; };
      };
      closeFloatsOnEscapeKey = true; # Close floating window UI on <ESC> press
      closeIfLastWindow = true; # Close Neovim if Neo-Tree is last window (*false)
      defaultComponentConfigs.diagnostics.symbols = {
        error = "✘";
        warn = "";
        info = "";
        hint = "";
      }; # vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
      filesystem = {
        filteredItems.forceVisibleInEmptyFolder = true; # Show hidden files in empty dir (*false)
        filteredItems.hideDotfiles = false; # Hide hidden files              (*true)
        findArgs = { fd = [ "--exclude" ".git" "--exclude" "node_modules" ]; }; # Args to pass find commands     (*null)
        useLibuvFileWatcher = true; # Detect changes w/ OS-level file watchers, not nvim autocmd events (*false)
        window.mappings = {
          "#" = "fuzzy_sorter";
          "." = "set_root";
          "[g" = "prev_git_modified";
          D = "fuzzy_finder_directory";
          "/" = "fuzzy_finder";
          "<bs>" = "navigate_up";
          "]g" = "next_git_modified";
          f = "filter_on_submit";
          "<C-x>" = "clear_filter";
          H = "toggle_hidden";
        };
      };
      gitStatus.window.mappings = {
        A = "git_add_all";
        ga = "git_add_file";
        gc = "git_commit";
        gu = "git_unstage_file";
        gr = "git_revert_file";
        gp = "git_push";
        gg = "git_commit_and_push";
      };
      popupBorderStyle = "NC"; # (*NC | double | none | rounded | shallow | single | solid)
      useDefaultMappings = true; # (*true)
      window = {
        autoExpandWidth = false; # Expand window width when file exceeds window width. Incompat: position='float' (*false)
        height = 15; # (*15)
        insertAs = "child"; # How to insert files in tree when cursor on dir  (*child | sibling)
        # Some commands take optional config options, see :h neo-tree-mappings
        mappings = {
          "<2-LeftMouse>" = "open";
          "<cr>" = "open";
          "<" = "prev_source";
          S = "open_split";
          w = "open_with_window_picker";
          q = "close_window";
          ">" = "next_source";
          s = "open_vsplit";
          t = "open_tabnew";
          C = "close_node";
          z = "close_all_nodes";
          l = "focus_preview";
          "<esc>" = "revert_preview";
          R = "refresh";
          e = "toggle_auto_expand_width";
          c = "copy";
          m = "move";
          r = "rename";
          d = "delete";
          y = "copy_to_clipboard";
          x = "cut_to_clipboard";
          p = "paste_from_clipboard";
          A = "add_directory";
          "?" = "show_help";
          "<space>" = { command = "toggle_node"; config.nowait = true; }; # `nowait`: Use existing combos w/ begin char
          P = { command = "toggle_preview"; config.use_float = true; };
          a = { command = "add"; config.show_path = "none"; }; # show_path = "none|relative|absolute"
        };
        popup = { position = "80%"; size.height = "80%"; size.width = "50%"; };
        position = "left"; # left | right | top | bottom | float | current
        sameLevel = false; # Create/paste/move files/dirs on same level as dir under cursor (vs w/i dir under cursor)
        width = 40;
      };
    };

    # --- Netman -----------------------
    # Access network resources in Neovim
    netman = {
      enable = false;
      neoTreeIntegration = config.programs.nixvim.plugins.neo-tree.enable; #true;
    };

    # --- Noice.nvim -------------------
    # https://github.com/folke/noice.nvim
    #
    # Alternate UI for Neovim. Completely replaces cmdline, messages, popupmenu
    #
    # - Treesitter requires parsers: vim, regex, lua, bash, markdown, markdown_inline
    # - Views are combination of: backend + options
    #
    # +--View----------+--Backend----+--Like------------------+--Options-|-Description----------------------------+
    # | notify         | notify      | nvim-notify            | { title, level, replace=false, merge=false }      |
    # | split          | split       | nui.nvim               | {                                size=auto,       |
    # | vsplit         | split       | nui.nvim               |                          position=auto,           |
    # | popup          | popup       | nui.nvim               | win_options.winhighlight.<hl-group>=<hl-group> }  |
    # | mini           | mini        | notifier/fidget.nvim   | Default position: bottom-right                    |
    # | cmdline        | popup       | cmdline                | Similar to native cmdline, bottom line            |
    # | cmdline_popup  | popup       | Fancy cmdline popup    | Diff styles according to cmdline mode             |
    # | cmdline_output | split       | presets.cmdline_output_to_split |                                          |
    # | messages       | split       | Split `:messages`      |                                                   |
    # | confirm        | popup       | Popup: `confirm` event |                                                   |
    # | hover          | popup       | Popup: LSP Signature   | Popup for help / hover                            |
    # | popupmenu      | nui.menu    | popupmenu.backend=nui  | Special popupmenu w render options if backend=nui |
    # |                | virtualtext | Message: virtualtext   | (ex:search_count) {hl_group=<hl-group>}           |
    # |                | notify_send | Desktop notification   |                                                   |
    # +---------------------------+-------------------------------------------------------------------------------+
    # |
    # +--Formatters--+
    # | level    | <level>=
    # | text     |
    # | message  |
    # | progress |
    # | title    |
    # | event    |
    # | kind     |
    # | date     |
    # | confirm  |
    # | cmdline  |
    # | spinner  |
    # | data     |
    noice = {
      enable = true;
      #extraOptions = {};
      cmdline = {
        enabled = true;
        view = "cmdline"; # cmdline_popup | cmdline
        #format = {};
        #opts = {};
      };
      #commands = {
      #};
      #format = {
      #};
      popupmenu = {
        enabled = true;
        backend = "nui"; # (nui | cmp)
      };
      notify = {
        enabled = true;
        #view = "notify";
        #stages = "slide"; # stages: fade_in_slide_out | fade | slide | static
      };

      lsp = {
        documentation = {
          #opts = {};
          view = "hover";
        };
        hover = {
          enabled = true;
          silent = false;
          #opts = {};
          #view = null;
        };
        message = {
          enabled = true;
          view = "notify";
          #opts = {};
        };
        progress = {
          enabled = true;
          format = "lsp_progress";
          format_done = "lsp_progress_done";
          view = "mini";
        };
        signature = {
          enabled = true;
          auto_open = {
            enabled = true;
            trigger = true;
            luasnip = true;
          };
          #view = null;
          #opts = {};
        };

        override = { };
      };

      presets = {
        bottom_search = true; # Puts search in bottom line
        command_palette = true; # Puts command entry line at top-center
        inc_rename = true;
        long_message_to_split = true; # Open long messages in split instead of notify UI
        lsp_doc_border = true; # Add border to hover docs & signature help
      };
    };

    # --- null-ls ----------------------
    # Integrate external sources with native nvim LSP
    null-ls = {
      enable = true;
      border = "rounded"; # none | single | double | rounded | solid | shadow
      #diagnosticConfig = {};
      #shouldAttach = "";  # User-defined function(buffer_number) that controls whether to enable null-ls for buffer.
      sources = {
        code_actions = {
          gitsigns.enable = true;
          shellcheck.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          cppcheck.enable = true;
          deadnix.enable = true;
          flake8.enable = true;
          gitlint.enable = true;
          shellcheck.enable = true;
          statix.enable = true;
        };
        formatting = {
          # Nix
          alejandra.enable = true;
          nixfmt.enable = false;
          nixpkgs_fmt.enable = false;

          black.enable = true;
          cbfmt.enable = true;
          fnlfmt.enable = true;
          fourmolu.enable = true;
          phpcbf.enable = true;
          prettier.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
          taplo.enable = true;
        };
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
      mapCW = true; # Delete pair w/ CTRL-W
    };
    surround.enable = false;
    endwise.enable = false;
    vim-matchup = {
      enable = false;
      enableSurround = true;
      enableTransmute = true;
      textObj.linewiseOperators = [ "d" "y" ]; # Modify set of operators which may operate line-wise
      treesitterIntegration.enable = true;
      treesitterIntegration.includeMatchWords = true; # Include vim regex matches for symbols. e.g. /* */ comments in C++ which are not supported by treesitter matching
    };
    emmet = {
      enable = false;
      leader = null;
      mode = null; # i | n | v | a
      settings = null;
    };


    # indent-blankline.vim - Show indentation guides
    indent-blankline = {
      enable = true;
      buftypeExclude = [ "terminal" "nofile" "quickfix" "prompt" ];
      #contextPatterns = [ "class" "^func" "method" "^if" "while" "for" "with" "try" "except" "arguments" "argument_list" "object" "dictionary" "element" "table" "tuple" "do_block" ];
      filetypeExclude = [ "lspinfo" "packer" "checkhealth" "help" "man" ];
      spaceCharBlankline = " ";
      showCurrentContext = true;
      showCurrentContextStart = true; # Applies highlight group `hl-IndentBlanklineContextStart` to first line in current context.
      showCurrentContextStartOnCurrentLine = true; # Apply ^^ even when cursor on same line
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
      extraOptions = { };
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
      formatting.fields = [ "kind" "abbr" "menu" ];
      #mappingPresets = [ "insert" "cmdline" ];
      preselect = "Item"; # Item | None
      snippet.expand = "luasnip"; # luasnip | snippy | ultisnips | vsnip | function()
      sources = [
        { name = "treesitter"; }
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_document_symbol"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "luasnip"; }
        { name = "dap"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "calc"; }
      ];
      window.completion = {
        colOffset = 0;
        scrollbar = true;
        scrolloff = 0;
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
    cmp-copilot.enable = false;
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
    cmp-tabnine.extraOptions = { };
    cmp-tmux.enable = false;
    cmp-treesitter.enable = true;
    cmp-vim-lsp.enable = false;
    cmp-vimwiki-tags.enable = false;
    cmp-vsnip.enable = false;
    cmp-zsh.enable = true;
    cmp_luasnip.enable = true;

    nvim-jdtls.enable = false; # Java LSP configuration
    #nvim-jdtls.data = "/path/to/your/workspace";


    # --- Highlighting -----------------
    # Highlight marks on backtick press
    mark-radar.enable = true; # TODO: Match highlight group `highlightGroup = "RadarMark"` w/ theme accent

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
        enabledGraphvizBackends = [ "dot" "jpg" "json" "pdf" "plain-ext" "png" "svg" "webp" "x11" ];
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
      nixvimInjections = true; # Enable Nixvim-specific injections (like Lua highlighting in extraConfigLua)
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
      opener = "split"; # edit | split | vsplit | tabe | drop
      position = "auto"; # wintype=split: leftabove | aboveleft | rightbelow | belowright | topleft | botright
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
      display = [ "VirtualTextOk" "LongTempFloatingWindowOk" "NvimNotifyOk" "TerminalErr" ];
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
  };


  # --- Aliases ---
  programs.nixvim.viAlias = true;
  programs.nixvim.vimAlias = true;
}
