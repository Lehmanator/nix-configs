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
      all = {};
      frappe = {};
      latte = {};
      macchiato = {};
      mocha = {};
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
      booleans = [];
      comments = ["italic"];
      conditionals = ["italic"];
      functions = [];
      keywords = ["bold"];
      loops = [];
      numbers = [];
      operators = ["bold"];
      properties = [];
      strings = [];
      types = [];
      variables = [];
    };

    # TODO: All integrations
    integrations = with config.programs.nixvim.plugins; {
      aerial = true;
      barbar = barbar.enable;
      beacon = true;
      cmp = nvim-cmp.enable;
      coc_nvim = true;
      dap.enabled = dap.enable; dap.enable_ui = dap.extensions.dap-ui.enable;
      dashboard = dashboard.enable;
      fern = true;
      fidget = true;
      gitgutter = gitgutter.enable;
      gitsigns = gitsigns.enable;
      harpoon = true;
      headlines = true;
      hop = true;
      illuminate = true;
      leap = true;
      lightspeed = true;
      lsp_saga = lspsaga.enable;
      lsp_trouble = trouble.enable;
      markdown = true;
      mason = true;
      mini = true;
      navic.enabled = true; navic.custom_bg = "NONE";
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

      barbecue = { # VSCode-like window symbol hierarchy/scope/nesting line
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
          errors = ["underline"];
          hints = ["underline"];
          information = ["underline"];
          warnings = ["underline"];
        };
        virtual_text = {
          errors = ["italic"];
          hints = ["italic"];
          information = ["italic"];
          warnings = ["italic"];
        };
      };
    };
  };
}
