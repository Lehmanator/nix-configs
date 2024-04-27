{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
# TODO: Enable nvim-cmp sources based on if relevant language / tool is enabled in NixOS / home-manager config.
# TODO: Migrate to using either lib:
#       - makeNixvim
#       - makeNixvimWithModule { pkgs = <nixpkgs>; module = <nixModule>; };
# TODO: Import config / package w/ custom Nixvim config in devShells
# TODO: Move borderStyle & theme logic to separate Nix module
{
  programs.nixvim.plugins = {
    cmp-buffer.enable = true; # Words from buffers
    cmp-calc.enable = true; # Calculation items
    cmp-cmdline.enable = true; # Items from cmdline buffer (vim or shell?)
    cmp-cmdline-history.enable =
      true; # Items from cmdline history (vim or shell?)
    cmp-conventionalcommits.enable = true; # Items from Git commits ???
    #cmp-copilot.enable = false;             # GitHub Copilot
    cmp-dap.enable = true; # Diagnostics
    cmp-dictionary.enable = true; # Words from dictionary
    cmp-digraphs.enable = true;
    cmp-emoji.enable = true; # Suggest emoji
    cmp-fish.enable = config.programs.fish.enable; # Fish shell keywords
    cmp-fuzzy-buffer.enable = true; # Fuzzy buffer words
    cmp-fuzzy-path.enable = true; # Fuzzy filesystem paths
    cmp-git.enable = true; # Git items
    cmp-greek.enable = true; # Greek symbols
    #cmp-latex-symbols.enable = true;        # Symbols from LaTeX
    cmp-look.enable = true;
    cmp-npm.enable = true; # Node.js packages

    cmp-nvim-lsp.enable = true; # Neovim LSP items
    cmp-nvim-lsp-document-symbol.enable =
      true; # Neovim LSP symbols from documents
    cmp-nvim-lsp-signature-help.enable = true; # Neovim LSP symbol signatures

    cmp-nvim-lua.enable = true; # Neovim Lua syntax & libs

    cmp-omni.enable = true; # Omnicomplete functions from regular Vim/Neovim

    cmp-pandoc-nvim.enable = config.programs.pandoc.enable; # Pandoc
    cmp-pandoc-references.enable =
      config.programs.pandoc.enable; # Pandoc references

    cmp-path.enable = true; # Filesystem paths
    cmp-rg.enable = true; # Ripgrep
    cmp-spell.enable = false; # Spelling suggestions ?

    cmp-tabnine = {
      # Autocompletion from ML suggestion model
      enable = false;
      #extraOptions = { };
    };

    cmp-tmux.enable = config.programs.tmux.enable; # Tmux words
    cmp-vimwiki-tags.enable = false; # VimWiki tags
    cmp-zsh.enable = config.programs.zsh.enable; # Zsh keywords
    cmp_luasnip.enable = config.programs.nixvim.plugins.luasnip.enable;

    nvim-jdtls.enable = false; # Java LSP configuration
    #nvim-jdtls.data = "/path/to/your/workspace";

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        completion = {
          autocomplete = ["TextChanged"];
          completeopt = "menu,menuone,noselect";
          keywordLength = 1;
          #keywordPattern = "\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)";  # Default keyword pattern. Embedded as such: `[[PATTERN]]`  Options: null | "<str>"
        };

        #matching = {
        #  disallowFullfuzzyMatching = false;
        #  disallowFuzzyMatching = false;
        #  disallowPartialFuzzyMatching = true;
        #  disallowPartialMatching = false;
        #  disallowPrefixUnmatching = false;
        #};
        #performance = {
        #  asyncBudget = 1;          # Max time in ms an async function is allowed to run during one step of event loop
        #  debounce = 60;            # Debounce time. Interval used to group up completions from different sources for filter & display
        #  fetchingTimeout = 500;    # Timeout for candidate fetching process. nvim-cmp will wait to display the most priority source
        #  maxViewEntries = 200;     # Max items to show in entries list
        #  throttle = 30;            # Throttle time. Used to delay filtering & displaying completions.
        #};

        # --- Entry Sorting ----------------------------------
        # Function to  customize sorting behavior. You can use built-in comparators via `cmp.config.compare.*`
        #   Fn Signature: (fun(entry1:cmp.Entry, entry2:cmp.Entry): boolean | nil)[]
        #sorting.comparators = ["offset" "exact" "score" "recently_used" "locality" "kind" "length" "order"];

        # Each item's original priority (given by its source) will be...
        # - Increased by: (sources_total - (source_index - 1)) * priorityWeight
        # - Final Score:  final_score = orig_score + ((sources_total - (source_index - 1)) * priorityWeight)
        #   Default: 2
        #   Options: null | <int>
        #sorting.priorityWeight = 2;

        formatting = {
          expandableIndicator = true;
          fields = ["kind" "abbr" "menu"]; # ["menu" "abbr" "kind"];

          #format = ''
          #  function(entry, vim_item)
          #    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          #    local strings = vim.split(kind.kind, "%s", { trimempty = true })
          #    kind.kind = " " .. (strings[1] or "") .. " "
          #    kind.menu = "    (" .. (strings[2] or "") .. ")"
          #    return kind
          #  end,
          #'';

          #fields = [ "kind" "abbr" "menu" ];
          # Function used to customize appearance of completion menu. fun(entry:cmp.Entry, vim_item:vim.CompletedItem)
          #   Note: Value can be used to modify the `dup` property.
          #   Note: The `vim.CompletedItem` can contain the special properties `abbr_hl_group`, `kind_hl_group`, & `menu_hl_group`
          #    See: |complete-items|
          #format = ''
          #  function(entry, vim_item)
          #  end
          #'';                              # Default: "function(_, vim_item) return vim_item end"
        };

        #mappingPresets = ["insert"];
        #snippet.expand="luasnip";

        #mapping = {};
        # TODO: Move to ../../nixvim/keymaps.nix
        # TODO: Move to ../../nixvim/styles/menus.nix
        experimental.ghost_text = true;
        experimental.native_menu = false;

        #preselect="Item";
        sources = [
          {name = "nvim_lsp";}
          {name = "nvim_lsp_document_symbol";}
          {name = "nvim_lsp_signature_help";}
          {name = "treesitter";}
          {name = "dap";}
          {name = "luasnip";}
          {name = "omni";}
          {name = "path";}
          {name = "buffer";}
          {
            name = "calc";
          }
          #{ name = "<source_name>";
          #  entryFilter = "<filterFunction>";
          #   Function to filter certain entries from a given source.
          #     Function Signature: `function(entry:cmp.Entry, ctx:cmp.Context): boolean`.
          #     - Return  true = keep   entry
          #     - Return false = remove entry
          #     Ex: Hide all entries w/ kind = `Text` from the `nvim_lsp` filter using:
          #     - entryFilter = "function(entry, ctx) return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text' end"
          #  groupIndex = 1;           # Source group index. e.g. set groupIndex for source `buffer` to larger number if you dont want to see `buffer` items while `nvim-lsp` is available.
          #  keywordLength = 2;        # Source-specific keyword length to trigger auto completion
          #  keywordPattern = null;    # Source-specific keyword pattern. Provided pattern embedded as: `[[PATTERN]]` Options: null | str
          #  option = null             # Any specific options defined by the source itself. If direct lua code is needed, use `helpers.mkRaw`.  Options: null | attrset
          #  priority = 10;            # Source-specific priority value. Options: null | int
          #  triggerCharacters = [];   # Source-specific keyword pattern.  Options: null | [<str>...]
          #}
        ];
        view = {
          #entries = { name = "custom"; selection_order = "top_down"; };
          docs.autoOpen = true;
        };

        #TODO: Move to ../../nixvim/styles/spacing.nix
        #TODO: Move to ../../nixvim/styles/windows.nix
        window.completion = {
          # Completion menu window
          border = lib.mkDefault "rounded";
          colOffset =
            -4; # Offsets the completion window relative to the cursor.                 Default: null => 0

          scrollbar =
            true; # Whether scrollbar should be enabled if there are more items that fit. Default: null => true
          scrolloff =
            0; # Window scrolloff option. See: |'scrolloff'|.                          Default: null => 0
          sidePadding =
            0; # Amount of padding to add on completion window sides.                  Default: null => 1
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"; # Window highlight option. See: |nvim_open_win|. Default = null => "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
          zindex = null; # Window zindex. See |nvim_open_win|
        };

        window.documentation = {
          # Documentation window
          border = lib.mkDefault "rounded"; # ["" "" "" "" "" "" "" ""];
          #maxHeight = null;                          # Window's max height.  Default: null => math.floor(40*(40/vim.o.lines))
          #maxWidth  = null;                          # Window's max width.   Default: null => math.floor((40*2)*(vim.o.columns/(40*2*16/9)))
          #winhighlight = "FloatBorder:NormalFloat";  # Window's highlight option.  See: |nvim_open_win|. Default: null => "FloatBorder:NormalFloat"
          #zindex = null;                             # Window's zindex. See: |nvim_open_win|. Default: null
        };
      };
    };
  };
}
