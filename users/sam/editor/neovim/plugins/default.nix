{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./barbar.nix
    ./comment-nvim.nix
    ./dashboard.nix
    ./emmet.nix
    ./floaterm.nix
    ./gitmessenger.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./lsp.nix
    ./lualine.nix
    ./luasnip.nix
    ./markdown-preview.nix
    ./neogit.nix
    ./neorg.nix
    ./noice.nix
    ./notify.nix
    ./null-ls.nix
    ./nvim-autopairs.nix
    ./nvim-bqf.nix
    ./nvim-cmp.nix
    ./nvim-tree.nix
    ./rust-tools.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vim-matchup.nix
  ];

  # --- Plugins ---
  programs.nixvim.plugins = {
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

    # --- Code Actions -----------------
    nvim-lightbulb = {
      enable = lib.mkDefault true;
      float.enabled = true;
      autocmd.enabled = true;
      statusText.enabled = true;
      virtualText.enabled = true;
    };

    # --- UI Packages ------------------
    # trouble.nvim - Pretty list for showing:
    # - diagnostics   - references      - telescope results
    # - quickfix      - location lists
    trouble.enable = lib.mkDefault true;
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
    nvim-osc52 = {
      enable = lib.mkDefault true;
      keymaps = { enable = true; }; #copy="+<+leader>y"
    };
    # --- Pairs ------------------------
    surround.enable = lib.mkDefault false;
    endwise.enable = lib.mkDefault false;
    # --- Keymaps ----------------------
    easyescape.enable = lib.mkDefault true;
    # Highlight marks on backtick press
    # TODO: Match highlight group `highlightGroup = "RadarMark"` w/ theme accent
    mark-radar.enable = lib.mkDefault true;

    # Highlight colors (names, rgb, hex, etc.)
    #nvim-colorizer.enable = true;
    specs = { # Show cursor jumps with highlights
      enable = lib.mkDefault true;
      min_jump = 3;
      width = 5;
    };
    todo-comments.enable = lib.mkDefault true; # Highlight comments with TODO
    startify.enable = lib.mkDefault false;
    lastplace.enable = lib.mkDefault true;
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nix-develop-nvim
    statix
    vim-addon-nix # TODO: Handled by LSP?
    vim-nix
    vim-nixhash
    vim2nix
  ];

}
