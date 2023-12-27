{ inputs
, config
, lib
, ...
}:
let
  isLspCmp = with config.programs.nixvim.plugins; lsp.enable && nvim-cmp.enable;
in
{

  # --- Language Server Protocol -----
  programs.nixvim.plugins = {
    cmp-nvim-lsp.enable = lib.mkDefault isLspCmp;
    cmp-nvim-lsp-document-symbol.enable = lib.mkDefault isLspCmp;
    cmp-nvim-lsp-signature-help.enable = lib.mkDefault isLspCmp;
    cmp-vim-lsp.enable = false; #lib.mkDefault isLspCmp;

    lsp = {
      enable = true;

      # --- Lua Hooks --------------------------------------
      # Note: These hooks may be able to be overridden per-server under: `plugins.lsp.servers.<server>.<option>`
      ## Lua code that modifies inplace the  `capabilities` table.
      #capabilities = ''
      #'';
      ## Lua function to be run when a new LSP buffer is attached. The argument `client` & `bufnr` is provided.
      #onAttach = ''
      #'';
      ## Code to be run after loading the LSP. This is an internal option
      #postConfig = ''
      #'';
      ## Code to be run before loading the LSP. Useful for requiring plugins
      #preConfig = ''
      #'';
      ## Code to be run to wrap the setup args.
      ##   Takes in an argument containing the previous results, & returns a new string of code.
      ##   Option: List<LuaFunctionReturningString>
      #setupWrappers = [
      #  ''
      #  ''
      #];

      # --- Language Servers -------------------------------
      # astrols:astro, bashls:bash, ccls:c/cpp,
      # TODO: Re-enable commented language servers after `inputs.nixos-unstable.pkgs.vscode-langservers-extracted` build succeeds again.
      # TODO: Conditionally enable based on if language programs are enabled in NixOS / home-manager config.
      servers = {
        bashls.enable = true;
        #ccls.enable = true;
        #ccls.initOptions = {
        #  compilationDatabaseDirectory = "";
        #  cache.directory = "/tmp/ccls-cache";  # TODO: Use XDG_CACHE_DIR (shared cache or per-user?)
        #  cache.format = "binary";  # binary | json
        #  cache.retainInMem = 2;  # 0=never-retain, 1=retain-after-initial-load, 2=retain-after-init-and-first-save
        #};
        clangd.enable = true;
        #cssls.enable = true;
        dartls.enable = true;
        #eslint.enable = true;
        gopls.enable = true;
        #html.enable = true;
        #jsonls.enable = true;
        lua-ls.enable = true;
        #nil_ls = {
        #  enable=true;
        #  settings = {
        #    diagnostics = {excludedFiles=[]; ignored=[];};
        #    formatting.command = [""];
        #  };
        #};
        nixd = {
          enable = true;
          settings = {
            eval = { depth = 3; workers = 5; }; # TODO: Set workers based on CPU cores on machine.
            formatting.command = "nixpkgs-fmt";
            options.enable = true;
          };
        };
        tailwindcss.enable = true;
        terraformls.enable = true;
        tsserver.enable = true;
        vuels.enable = true;
        #zls.enable = true;
      };
    };

    # lsp-lines - LSP multi-line diagnostics in-editor
    lsp-lines = {
      enable = true; #lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      currentLine = true; # Only show diagnostics on current line
    };

    # lsp-format - LSP file formatting
    lsp-format = {
      enable = true; #lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      lspServersToEnable = "all";
    };

    # lspkind.nvim - Entry types for LSP Completions w/ icons
    lspkind = {
      enable = true; #lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      mode = "symbol_text"; #"symbol_text";  # text|text_symbol|symbol_text*|symbol
      preset = "codicons"; # codicons|default   # TODO: Conditional based on style/theme icon type preference
      cmp = {
        enable = lib.mkDefault isLspCmp; # Integrate with nvim-cmp
        after = ''
          function(entry, vim_item, kind)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
          end
        '';
        ellipsisChar = "...";
        #after = null;                     # Function to run after calculating the formatting. function(entry,vim_item,kind)
        #ellipsisChar = null;              # Char to show when popup exceeds maxWidth. Options: null | str
        #maxWidth = null;                  # Max chars to show in the popup.           Options: null | int
        #menu = null;                      # Show source names in popup.               Options: null | attrs<str>
      };
      symbolMap = {
        Comment = "󰉿";
        String = "󰉿";
      };
    };

    # lspsaga.nvim - LSP enhancements
    # TODO: Compatible with Noice?
    lspsaga = {
      enable = true; # enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      beacon.enable = true; # Show a beacon to tell you where cursor moved after command causes jump
      beacon.frequency = 7; #
      #borderStyle = "rounded";           # Deprecated
      #callhierarchy.layout = "float";    # Options: float | normal
      codeAction = { extendGitSigns = true; showServerName = true; };
      definition = { height = 0.5; width = 0.5; }; # keys={}; }; # TODO: Remap keys (defaults use <C-c> + letter)
      diagnostic = {
        diagnosticOnlyCurrent = false; # # Only show virt text on curr line
        extendRelatedInformation = true; # When has `relatedInformation`, diagnostic msg extended to show it
        jumpNumShortcut = true;
        maxHeight = 0.6;
        maxShowHeight = 0.6;
        maxShowWidth = 0.9;
        maxWidth = 0.8;
        showCodeAction = true;
        showLayout = "float";
        showNormalHeight = 10;
        textHlFollow = true;
        keys = { execAction = "o"; quit = "q"; quitInShow = [ "q" "<ESC>" ]; toggleOrJump = "<CR>"; };
      };
      finder = {
        default = "ref+imp";
        filter = { };
        layout = "float";
        leftWidth = 0.3;
        maxHeight = 0.5;
        methods = { tyd = "textDocument/typeDefinition"; };
        rightWidth = 0.3;
        silent = false;
        keys = { close = "<C-c>k"; quit = "q"; shuttle = "[w"; split = "i"; tabe = "t"; tabnew = "r"; toggleOrOpen = "o"; vsplit = "s"; };
      };
      hover = { maxHeight = 0.6; maxWidth = 0.9; openCmd = "!firefox"; openLink = "gx"; };
      implement = { enable = true; sign = true; virtualText = true; };
      lightbulb = { enable = true; sign = true; virtualText = true; };
      outline = {
        autoClose = true;
        autoPreview = true;
        closeAfterJump = false;
        detail = true;
        layout = "normal"; #layout="float";
        leftWidth = 0.3;
        maxHeight = 0.5;
        winPosition = "right";
        winWidth = 30;
        keys = { jump = "e"; quit = "q"; toggleOrJump = "o"; };
      };
      rename = { autoSave = false; inSelect = true; projectMaxHeight = 0.5; projectMaxWidth = 0.5; keys = { exec = "<CR>"; quit = "<C-k>"; select = "x"; }; };
      scrollPreview = { scrollDown = "<C-f>"; scrollUp = "<C-b>"; };
      symbolInWinbar = { enable = true; colorMode = true; folderLevel = 1; hideKeyword = false; separator = "›"; showFile = true; };
      #ui={};
    };

    # inc-rename - Incremental previewing LSP renaming
    inc-rename.enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;

  };
}
