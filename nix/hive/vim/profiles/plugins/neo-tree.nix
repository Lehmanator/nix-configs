{ inputs
, config, lib, pkgs
, ...
}:
{
  # --- File Tree --------------------
  # File Tree plugin  # TODO: Compare:
  # - neo-tree   - nerdtree  - dirbuf.nvim  - iir.nvim
  # - nvim-tree  - nnn.nvim  - telescope-file-browser
  plugins.neo-tree = {
    enable = true;
    addBlankLineAtTop = false;
    autoCleanAfterSessionRestore = false; # Auto clean up broken neotree buffers saved in sessions
    buffers = {
      bindToCwd = true;
      followCurrentFile = true;
      groupEmptyDirs = true;
      window.mappings = { "<bs" = "navigate_up"; "." = "set_root"; bd = "buffer_delete"; };
    };
    closeFloatsOnEscapeKey = true; # Close floating window UI on <ESC> press
    closeIfLastWindow = true; # Close Neovim if Neo-Tree is last window (*false)
    defaultComponentConfigs.diagnostics.symbols = {
      error = "✘";
      warn = "";
      info = "";
      hint = "";
    }; # vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
    filesystem = {
      filteredItems.forceVisibleInEmptyFolder = true; # Show hidden files in empty dir (*false)
      filteredItems.hideDotfiles = false; # Hide hidden files              (*true)
      findArgs = { fd = [ "--exclude" ".git" "--exclude" "node_modules" ]; }; # Args to pass find commands     (*null)
      useLibuvFileWatcher = true; # Detect changes w/ OS-level file watchers, not nvim autocmd events (*false)
      window.mappings = {
        "#" = "fuzzy_sorter";
        "." = "set_root";
        "[g" = "prev_git_modified";
        D = "fuzzy_finder_directory";
        "/" = "fuzzy_finder";
        "<bs>" = "navigate_up";
        "]g" = "next_git_modified";
        f = "filter_on_submit";
        "<C-x>" = "clear_filter";
        H = "toggle_hidden";
      };
    };
    gitStatus.window.mappings = {
      A = "git_add_all";
      ga = "git_add_file";
      gc = "git_commit";
      gu = "git_unstage_file";
      gr = "git_revert_file";
      gp = "git_push";
      gg = "git_commit_and_push";
    };
    popupBorderStyle = "NC"; # (*NC | double | none | rounded | shallow | single | solid)
    useDefaultMappings = true; # (*true)
    window = {
      autoExpandWidth = false; # Expand window width when file exceeds window width. Incompat: position='float' (*false)
      height = 15; # (*15)
      insertAs = "child"; # How to insert files in tree when cursor on dir  (*child | sibling)
      # Some commands take optional config options, see :h neo-tree-mappings
      mappings = {
        "<2-LeftMouse>" = "open";
        "<cr>" = "open";
        "<" = "prev_source";
        S = "open_split";
        w = "open_with_window_picker";
        q = "close_window";
        ">" = "next_source";
        s = "open_vsplit";
        t = "open_tabnew";
        C = "close_node";
        z = "close_all_nodes";
        l = "focus_preview";
        "<esc>" = "revert_preview";
        R = "refresh";
        e = "toggle_auto_expand_width";
        c = "copy";
        m = "move";
        r = "rename";
        d = "delete";
        y = "copy_to_clipboard";
        x = "cut_to_clipboard";
        p = "paste_from_clipboard";
        A = "add_directory";
        "?" = "show_help";
        "<space>" = { command = "toggle_node"; config.nowait = true; }; # `nowait`: Use existing combos w/ begin char
        P = { command = "toggle_preview"; config.use_float = true; };
        a = { command = "add"; config.show_path = "none"; }; # show_path = "none|relative|absolute"
      };
      popup = { position = "80%"; size.height = "80%"; size.width = "50%"; };
      position = "left"; # left | right | top | bottom | float | current
      sameLevel = false; # Create/paste/move files/dirs on same level as dir under cursor (vs w/i dir under cursor)
      width = 40;
    };
  };
}
