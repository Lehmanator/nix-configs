{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.colorschemes.catppuccin = {
    enable = lib.mkDefault true;
    # TODO: All integrations
    integrations = with config.programs.nixvim.plugins; {
      aerial = true;
      barbar = barbar.enable;
      beacon = true;
      cmp = nvim-cmp.enable;
      coc_nvim = true;
      dap.enabled = dap.enable;
      dap.enable_ui = dap.extensions.dap-ui.enable;
      dashboard = dashboard.enable;
      fern = true;
      fidget = true;
      gitgutter = gitgutter.enable;
      gitsigns = gitsigns.enable;
      harpoon = true;
      headlines = true;
      hop = true;
      illuminate = true;
      indent_blankline.enabled = true;
      #indent_blankline.colored_indent_levels = true;
      leap = true;
      lightspeed = true;
      lsp_saga = lspsaga.enable;
      lsp_trouble = trouble.enable;
      markdown = true;
      mason = true;
      mini = true;
      native_lsp.enabled = true;
      neogit = neogit.enable;
      neotest = true;
      neotree = true;
      noice = noice.enable;
      notify = true;
      nvimtree = true;
      octo = true;
      overseer = true;
      pounce = true;
      rainbow_delimiters = rainbow-delimiters.enable;
      sandwich = true;
      semantic_tokens = true;
      symbols_outline = true;
      telekasten = true;
      telescope = telescope.enable;
      treesitter = treesitter.enable;
      treesitter_context = treesitter-context.enable;
      ts_rainbow = true;
      ts_rainbow2 = true;
      vim_sneak = true;
      vimwiki = true;
      which_key = which-key.enable;

    };
    terminalColors = true;
    transparentBackground = true;
  };
}
