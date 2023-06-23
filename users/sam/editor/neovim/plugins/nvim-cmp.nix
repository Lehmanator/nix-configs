{ inputs
, config
, ...
}:
let
  borderStyle = "rounded";
  borderCharSets = {
    rounded = [ "" "" "" "" "" "" "" "" ];
    none = [ "" "" "" "" "" "" "" "" ];
    square = [ "" "" "" "" "" "" "" "" ];
    double=["╔" "═" "╗" "║" "╝" "═" "╚" "║"];
    border=["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
    single=["┌" "─" "┐" "│" "┘" "─" "└" "│"];
    #flaoterm="─│─│┌┐┘└";
  };
  borderChars = borderCharSets."${borderStyle}";
in
{
  programs.nixvim.plugins = {
    cmp-buffer.enable = true;
    cmp-calc.enable = true;
    cmp-cmdline.enable = true;
    cmp-cmdline-history.enable = true;
    cmp-conventionalcommits.enable = true;
    #cmp-copilot.enable = false;
    cmp-dap.enable = true;
    cmp-dictionary.enable = true;
    cmp-digraphs.enable = true;
    cmp-emoji.enable = true;
    cmp-fish.enable = config.programs.fish.enable;
    cmp-fuzzy-buffer.enable = true;
    cmp-fuzzy-path.enable = true;
    cmp-git.enable = true;
    cmp-greek.enable = true;
    cmp-look.enable = true;
    cmp-npm.enable = true;
    cmp-nvim-lua.enable = true;
    cmp-omni.enable = true;
    cmp-pandoc-nvim.enable = true;
    cmp-pandoc-references.enable = true;
    cmp-path.enable = true;
    cmp-rg.enable = true;
    cmp-spell.enable = false;
    cmp-tabnine.enable = false;
    cmp-tabnine.extraOptions = { };
    cmp-tmux.enable = false;
    cmp-vimwiki-tags.enable = false;
    cmp-zsh.enable = true;

    nvim-jdtls.enable = false; # Java LSP configuration
    #nvim-jdtls.data = "/path/to/your/workspace";

    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      completion.autocomplete = ["TextChanged"];
      completion.completeopt = "menu,menuone,noselect";
      completion.keywordLength = 1;
      mapping = {
        # if cmp.visible() then
        #   cmp.select_next_item(select_opts) -- If menu open, <Tab> moves to next item
        # elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        #   fallback()     -- Insert <Tab> char if line is "empty"
        # else
        #   cmp.complete() -- If cursor is inside a word, trigger menu
        "<CR>" = {
          modes = ["i" "s" ];
          action = "cmp.mapping.confirm({ select = true })";
        };
        "<Tab>" = {
          modes = [ "i" "s" ];
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
          modes = [ "i" "s" ];
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
      #confirmation.getCommitCharacters = "function(commit_characters return commit_characters end)";
      experimental.ghost_text = true;
      experimental.native_menu = false;

      formatting.fields = [ "kind" "abbr" "menu" ];
      #formatting.format = ''
      #  function(entry, vim_item)
      #  end
      #'';
      #mappingPresets = ["cmdline"]; #"[ \"insert\" \"cmdline\" ]";
      preselect = "Item"; # Item | None
      sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_document_symbol"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "luasnip"; }
        { name = "omni"; }
        { name = "treesitter"; }
        { name = "dap"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "calc"; }
      ];
      window.completion = {
        border = borderChars;
        colOffset = 0;
        scrollbar = true;
        scrolloff = 0;
        sidePadding = 1;
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None";
      };
      window.documentation = { winhighlight = "FloatBorder:NormalFloat"; }; #border = ["" "" "" "" "" "" "" ""];
    };
  };
}
