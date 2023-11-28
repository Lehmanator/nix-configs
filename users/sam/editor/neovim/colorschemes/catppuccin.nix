{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.colorschemes.catppuccin = {
    #enable = lib.mkDefault false;

    showBufferEnd = false; # Show `~` after end of buffers
    terminalColors = true;
    transparentBackground = true;

    dimInactive = {
      enabled = true; # Dim BG when window/buf/split is inactive
      percentage = 0.15;
      #shade = dark;
    };

    # --- Styling, Highlights, & Overrides ---
    colorOverrides = {
      all = { };
      frappe = { };
      latte = { };
      macchiato = { };
      mocha = { };
    };

    #customHighlights = ''
    #  function(colors)
    #    return {
    #      Comment               = { fg = colors.flamingo                       },
    #      [“@constant.builtin”] = { fg = colors.peach,    style = {          } },
    #      [“@comment”]          = { fg = colors.surface2, style = { “italic” } },
    #    }
    #  end
    #'';

    # TODO: Make some symbol classes bold & others italic
    styles = {
      booleans = [ ];
      comments = [ "italic" ];
      conditionals = [ "italic" ];
      functions = [ ];
      keywords = [ "bold" ];
      loops = [ ];
      numbers = [ ];
      operators = [ "bold" ];
      properties = [ ];
      strings = [ ];
      types = [ ];
      variables = [ ];
    };

    # TODO: All integrations
    integrations = with config.programs.nixvim.plugins; {
      aerial = true;
      barbar = true; #barbar.enable;
      beacon = true;
      cmp = true; #nvim-cmp.enable;
      coc_nvim = true;
      dap.enabled = true; #dap.enable;
      dap.enable_ui = true; #dap.extensions.dap-ui.enable;
      dashboard = true; #dashboard.enable;
      fern = true;
      fidget = true;
      gitgutter = true; #gitgutter.enable;
      gitsigns = true; #gitsigns.enable;
      harpoon = true;
      headlines = true;
      hop = true;
      #illuminate = true;
      leap = true;
      lightspeed = true;
      lsp_saga = true; #lspsaga.enable;
      lsp_trouble = true; #trouble.enable;
      markdown = true;
      mason = true;
      #mini = true;
      navic.enabled = true;
      navic.custom_bg = "NONE";
      neogit = true; #neogit.enable;
      neotest = true;
      neotree = true;
      noice = true; #noice.enable;
      notify = true;
      nvimtree = true;
      octo = true;
      overseer = true;
      pounce = true;
      rainbow_delimiters = true; #rainbow-delimiters.enable;
      sandwich = true;
      semantic_tokens = true;
      symbols_outline = true;
      telekasten = true;
      treesitter = true; #treesitter.enable;
      treesitter_context = true; #treesitter-context.enable;
      ts_rainbow = true;
      ts_rainbow2 = true;
      vim_sneak = true;
      vimwiki = true;
      which_key = true; #which-key.enable;

      barbecue = {
        # VSCode-like window symbol hierarchy/scope/nesting line
        alt_background = false;
        bold_basename = true;
        dim_context = false;
        dim_dirname = true;
      };
      indent_blankline = {
        enabled = true;
        colored_indent_levels = true; # D:false
      };
      native_lsp = {
        enabled = true;
        underlines = {
          errors = [ "underline" ];
          hints = [ "underline" ];
          information = [ "underline" ];
          warnings = [ "underline" ];
        };
        virtual_text = {
          errors = [ "italic" ];
          hints = [ "italic" ];
          information = [ "italic" ];
          warnings = [ "italic" ];
        };
      };
      #telescope = {
      #  enabled = true; #telescope.enable;
      #  #style = "";
      #};
    };
  };
}
