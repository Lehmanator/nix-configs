{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ./auto-session.nix #     # Auto save/restore Vim sessions
    ./barbar.nix #           # Status bar
    ./comment-nvim.nix #     #
    ./cursorline.nix #       # Cursor line/word highlight
    ./dap.nix #              # Diagnostics
    ./dashboard.nix #        # Startup screen
    ./emmet.nix #            # HTML tags
    ./floaterm.nix #         # Floating terminal
    ./gitmessenger.nix #     # Display Git log / message from last commit under cursor
    ./gitsigns.nix #         # Git sign column
    ./indent-blankline.nix # # Indent new lines
    ./lsp.nix #              # Language server protocol
    ./lualine.nix #          # Statusline
    ./luasnip.nix #          # Snippets
    ./markdown-preview.nix # # Render Markdown previews
    ./neogit.nix #           # Magit for neovim
    ./neorg.nix #            # Organization notes
    ./noice.nix #            # Experimental UI
    ./notify.nix #           # Notification UI
    ./none-ls.nix #         # Integration w/ LSP
    ./nvim-autopairs.nix #   # Pair matching
    ./nvim-bqf.nix #         #
    ./nvim-cmp.nix #         # Completion engine
    ./nvim-colorizer.nix #   # Color highlighter
    #./nvim-lightbulb.nix #  # Code Actions
    ./nvim-tree.nix #        # File tree
    ./nvim-ufo.nix #         # Code folding UI
    ./ollama.nix #           # Ollama LLM prompting
    ./rust-tools.nix #       # Rust utils
    ./tagbar.nix #           # Bar for tags
    ./telescope.nix #       # Search result UIs
    ./todo-comments.nix #    # Highlight todos & more
    ./treesitter.nix #       # Syntax trees
    ./trouble.nix #          # Pretty UIs: diagnostics, refs, telescope, quickfix, location lists
    ./vim-matchup.nix #      # Highlight matching pairs
    ./which-key.nix #        # UI to show next keymaps
    ./yanky.nix #            # Improved Yanking

    # TODO: Move plugins to separate file
    #./netman.nix            # Access network resources in Neovim
    #./nvim-osc52.nix        # Native system clipboard
    #./sniprun.nix           # Snippet runner
    #./specs.nix             # Visualize vim motions, selections, jumps
    #./startify.nix          # Start page

    # TODO: Add new plugins
    #./instant.nix           # Collaborative editing
    #./lastplace.nix         # Remember last editor position (conflict w/ auto-session ?)
    #./oil.nix               # Edit filesystem like Vim buffer
    #./spider.nix            # CamelCase word motions
  ];

  # --- Plugins ---
  programs.nixvim.luaLoader.enable = true; # Experimental lua loader w/ byte-compilation cache
  programs.nixvim.plugins = {
    # +--- Nix / NixOS --------------------------------------------------------+
    # |                                                                        |
    # | nix-develop.nvim - Run `nix develop` without restarting Neovim.        |
    # |                                                                        |
    # | Repo: https://github.com/figsoda/nix-develop.nvim/                     |
    # |                                                                        |
    # | Commands:                                                              |
    # | - :NixDevelop .#<devShellName> --impure                                |
    # | - :NixShell nixpkgs#hello                                              |
    # | - :RiffShell --project-dir foo                                         |
    # +------------------------------------------------------------------------+
    nix.enable = true;
    nix-develop = {
      enable = true;
      #package = pkgs.vimPlugins.nix-develop-nvim;

      # These attrs will be added to the table parameter for the setup function.
      # Typically, it can override NixVim’s default settings.
      extraOptions = {
      };

      # Env vars to ignore?
      ignoredVariables = {};

      # Env vars to split w/ separator?
      separatedVariables = {};
    };


    # --- Browser ----------------------
    # Integrate browser textboxes with Neovim config
    #firenvim.enable = lib.mkDefault true;

    # --- Jupyter Notebooks ------------
    # FIX: Missing Python package `kaleido` which is not in `nixpkgs`
    #magma-nvim = { enable = true; automaticallyOpenOutput = true; }; # Call :MagmaShowOutput on cell run

    # --- Netman -----------------------
    # Access network resources in Neovim
    netman = {
      enable = lib.mkDefault false;
      neoTreeIntegration = config.programs.nixvim.plugins.neo-tree.enable; #true;
    };

    # Tab indents to proper level based on syntax
    intellitab.enable = lib.mkDefault true;

    # --- UI Packages ------------------
    undotree.enable = lib.mkDefault true;

    # --- Projects ---------------------
    project-nvim.enable = lib.mkDefault true;

    # --- Runners ----------------------
    sniprun = {
      enable = lib.mkDefault true;
      display = [ "VirtualTextOk" "LongTempFloatingWindowOk" "NvimNotifyOk" "TerminalErr" ];
      #liveModeToggle = "on";
      #replEnable = [];
    };

    # --- Comments ---------------------
    comment-nvim.enable = lib.mkDefault true;
    commentary.enable = lib.mkDefault false;

    # --- System Integration -----------
    #../../nixvim/clipboard.nix
    nvim-osc52 = {
      enable = true; # Default=false
      keymaps.enable = true;
      keymaps.silent = false;
    };

    # --- Pairs ------------------------
    #./nvim-autopairs.nix
    # TODO: Disable keymaps when plugins.vim-matchup.enableSurround|Transmute = true
    surround.enable = lib.mkDefault true;
    endwise.enable = lib.mkDefault true;

    # --- Keymaps ----------------------
    easyescape.enable = lib.mkDefault true;
    # Highlight marks on backtick press
    # TODO: Match highlight group `highlightGroup = "RadarMark"` w/ theme accent
    mark-radar.enable = lib.mkDefault true;

    specs = {
      # Show cursor jumps with highlights
      enable = lib.mkDefault true;
      min_jump = 3;
      width = 5;
    };
    startify.enable = lib.mkDefault false;
    lastplace.enable = lib.mkDefault true;
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nix-develop-nvim
    statix
    #telescope-manix  # Nix documentation & option search integration with Telescope.nvim
    vim-addon-nix # TODO: Handled by LSP?
    vim-nix
    vim-nixhash
    vim2nix
    sved # synctex support b/w Vim/Neovim & Evince # TODO: iff systemConfig.programs.evince.enable=true;
  ];

}
