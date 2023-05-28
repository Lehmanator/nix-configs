{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    # TODO: All integrations
    integrations = {
      aerial = true;
      barbar = true;
      beacon = true;
      cmp = true;
      coc_nvim = true;
      dap.enable_ui = true;
      dashboard = true;
      fern = true;
      fidget = true;
      gitgutter = true;
      gitsigns = true;
      harpoon = true;
      headlines = true;
      hop = true;
      illuminate = true;
      indent_blankline.enabled = true;
      #indent_blankline.colored_indent_levels = true;
      leap = true;
      lightspeed = true;
      lsp_saga = true;
      lsp_trouble = true;
      markdown = true;
      mason = true;
      mini = true;
      native_lsp.enabled = true;
      neogit = true;
      neotest = true;
      neotree = true;
      noice = true;
      notify = true;
      nvimtree = true;
      octo = true;
      overseer = true;
      pounce = true;
      sandwich = true;
      semantic_tokens = true;
      symbols_outline = true;
      telekasten = true;
      telescope = true;
      treesitter = config.programs.nixvim.plugins.treesitter.enable;
      treesitter_context = config.programs.nixvim.plugins.treesitter-context.enable;
      ts_rainbow = true;
      ts_rainbow2 = true;
      vim_sneak = true;
      vimwiki = true;
      which_key = true;

    };
    terminalColors = true;
    transparentBackground = true;
  };
}
