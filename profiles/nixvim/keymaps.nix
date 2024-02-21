{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  plugins = {
    #dap.extensions.dap-ui = {
    #  elementMappings.<name> = {
    #    edit = "e";
    #    expand = ["<CR>" "<2-LeftMouse>"];
    #    open = "o";
    #    remove = "d";
    #    repl = "r";
    #    toggle = "t";
    #  };
    #  floating.mappings.close = ["<ESC>" "q"];
    #  mappings = {
    #    edit = "e";
    #    expand = ["<CR>" "<2-LeftMouse>"];
    #    open = "o";
    #    remove = "d";
    #    repl = "r";
    #    toggle = "t";
    #  };
    #};

    #floaterm.keymaps = {
    #  first="";
    #  hide="";
    #  kill="";
    #  last="";
    #  new="";
    #  next="";
    #  prev="";
    #  show="";
    #  toggle="";
    #};

    intellitab.enable = true;

    lsp.keymaps = {
      silent = false; # Whether nvim-lsp keymaps should be silent.
      diagnostic = {
        # Mappings for functions: `vim.diagnostic.<action>`
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        # Mappings for functions: `vim.lsp.buf.<action>`
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
        ca = "code_action";
        ff = "format";
      };
    };

    #lspsaga = {
    #  callhierarchy.keys = { # Mappings for lspsaga's call hierarchy window
    #    close = "<C-c>k";
    #    edit = "e";
    #    quit = "q";
    #    shuttle = "[w";
    #    split = "i";
    #    tabe = "t";
    #    toggleOrReq = "u";
    #    vsplit = "s";
    #  };
    #  codeAction.numShortcut = true;
    #  codeAction.keys = {
    #    exec = "<CR";
    #    quit = "q";
    #  };
    #  definition.keys = {
    #    close = "<C-c>k";
    #    edit = "<C-c>o";
    #    quit = "q";
    #    split = "<C-c>i";
    #    tabe = "<C-c>t";
    #    vsplit = "C-c>v";
    #  };
    #  diagnostic.keys = {
    #    execAction = "o"; # Execute action in jump window
    #    quit = "q"; # Quit key for the jump window
    #    quitInShow = "[q <ESC>]"; # Quit key for the diagnostic_show window
    #    toggleOrJump = "<CR>"; # Toggle or jump to position when in `diagnostic_show` window
    #  };
    #  finder.keys = {
    #    close = "<C-c>k"; # Close finder
    #    quit = "q"; # Quit the finder (only works in layout left window)
    #    shuttle = "[w"; # Shuttle b/w the finder layout window
    #    split = "i"; # Open in hsplit
    #    tabe = "t"; # Open in tabe
    #    tabnew = "r"; # Open in new tab
    #    toggleOrOpen = "o"; # Toggle expand or open
    #    vsplit = "s"; # Open in vsplit
    #  };
    #  outline.keys = {
    #    jump = "e"; # Jump to position even on a expand/collapse node
    #    quit = "q"; # Quit outline window
    #    toggleOrJump = "o"; # Toggle or jump
    #  };
    #  rename.keys = {
    #    exec = "<CR>"; # Execute rename in `rename` window or execute replace in `project_replace` window
    #    quit = "<C-k>"; # Quit rename or `project_replace` window
    #    select = "x"; # Select or cancel select item in `project_replace` float window.
    #  };
    #  scrollPreview.scrollDown = "<C-f>";
    #  scrollPreview.scrollUp = "<C-b>";
    #
    #  hover.openLink = "gx"; # Key to open link in browser.
    #
    #};

    nvim-autopairs = {
      #ignoredNextChar = "[=[[%w%%%'%[%"%.%%$]]=]";
      mapBs = true; # Map <BS> key to delete pair
      mapCH = false; # Map <C-h> key to delete pair
      mapCW = false; # Map <C-w> key to delete pair if possible
      mapCr = true; # Map <CR>  key to confirm the completion
      #pairs = null;
      disableInMacro = false;
      disableInReplaceMode = true;
      disableInVisualblock =
        false; # Disable when insert after visual block mode
    };

    nvim-cmp = {
      confirmation.getCommitCharacters = "function(commit_characters) return commit_characters end"; # You can append or exclude commitCharacters via this config option function. commitCharacters are defined by the LSP spec. Options: null | "<str>"
      preselect = "Item"; # Item | None
      #mappingPresets = ["cmdline"]; #"[ \"insert\" \"cmdline\" ]";
      mapping = {
        # if cmp.visible() then
        #   cmp.select_next_item(select_opts) -- If menu open, <Tab> moves to next item
        # elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        #   fallback()     -- Insert <Tab> char if line is "empty"
        # else
        #   cmp.complete() -- If cursor is inside a word, trigger menu
        "<CR>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.confirm({ select = true })";
        };
        "<Tab>" = {
          modes = ["i" "s"];
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
                -- expand_or_locally_jumpable() - Only jumps inside snippet region
                -- expand_or_jumpable()         - Can jump outside snippet region
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          '';
        };
        "<S-Tab>" = {
          modes = ["i" "s"];
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end
          '';
        };
      };
      #snippet.expand = null;  # luasnip | snippy | ultisnips | vsnip | attrs<LuaFunctionString>
      #  { __raw = ''
      #      function(args)
      #        vim.fn["vsnip#anonymous"](args.body)           -- For `vsnip` users.
      #        -- require('luasnip').lsp_expand(args.body)    -- For `luasnip` users.
      #        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      #        -- vim.fn["UltiSnips#Anon"](args.body)         -- For `ultisnips` users.
      #      end
      #    '';
      #  }
    };

    nvim-osc52.keymaps = {
      enable = true;
      copy = "<leader>y";
      copyLine = "<leader>yy";
      copyVisual = "<leader>y";
    };

    telescope.keymapsSilent = false;
    telescope.keymaps = {
      "<leader>fg" = "live_grep";
      "<C-p>" = {
        action = "git_files";
        desc = "Telescope Git Files";
      };
    };
    #todo-comments.keymaps.todoTelescope = {
    #  key = "<C-t>";
    #  keywords = "TODO,FIX,FIXME,CHANGEME,ERROR,WIP";
    #};
    #todo-comments.keymaps.todoTrouble = {
    #  key = "<C-T>";
    #  keywords = "TODO,FIX,FIXME,CHANGEME,ERROR,WIP";
    #};

    #treesitter.incrementalSelection.keymaps = {
    #  initSelection = "gnn";
    #  nodeDecremental = "grm";
    #  nodeIncremental = "grn";
    #  scopeIncremental = "grc";
    #};

    #treesitter-playground.keybindings = {
    #  focusLanguage = "f";
    #  gotoNode: "<cr>";
    #  showHelp: "?";
    #  toggleAnonymousNodes = "a";
    #  toggleHlGroups = "i";
    #  toggleInjectedLanguages = "t";
    #  toggleLanguageDisplay = "I";
    #  toggleQueryEditor = "o";
    #  unfocusLanguage = "F";
    #  update = "R";
    #};

    #treesitter-refactor.navigation.keymaps = {
    #  gotoDefinitionLspFallback = null;   # Fallback to `vim.lsp.buf.definition`. Use custom callback func if create mapping of "lua require('nvim-treesitter').refactor.navigation(nil,fallback_function)<cr>";
    #  gotoDefinition = "gnd";             # Go to symbol under cursor
    #  gotoNextUsage = "<a-*>";            # Go to next     usage of identifier
    #  gotoPrevUsage = "<a-#>";            # Go to previous usage of identifier
    #  listDefinitions = "gnD";            # List all definitions from current file
    #  listDefinitionsToc = "g0";          # List all definitions from current file like table of contents
    #};
    #treesitter-refactor.smartRename.keymaps.smartRename = "grr";  # Keymap to rename symbol under cursor

    trouble.actionKeys = {
      cancel = "<esc>";
      close = "q";
      closeFolds = ["zM" "zm"];
      hover = "K";
      jump = ["<cr>" "<tab>"];
      jumpClose = ["o"];
      next = "j";
      openFolds = ["zR" "zr"];
      openSplit = ["<c-x>"];
      openTab = ["<c-t>"];
      openVsplit = ["<c-v>"];
      preview = "p";
      previous = "k";
      refresh = "r";
      toggleFold = ["zA" "za"];
      toggleMode = "m"; # Toggle b/w modes: `workspace` & `document`
      togglePreview = "P"; # Toggle auto-preview
    };
  };
}
