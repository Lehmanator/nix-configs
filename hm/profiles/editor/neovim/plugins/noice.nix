{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.noice = {
    enable = false;
    #extraOptions = {};
    cmdline = {
      enabled = true;
      view = "cmdline"; # cmdline_popup | cmdline
      #opts = {};
      format = {
        cmdline = {
          pattern = "^:";
          icon = "Command  :";
          lang = "vim";
        };
        search_down = {
          kind = "search";
          pattern = "^/";
          icon = " ";
          lang = "regex";
        };
        search_up = {
          kind = "search";
          pattern = "?%?";
          icon = " ";
          lang = "regex";
        };
        filter = {
          pattern = "^:%s*!";
          icon = "Filter $";
          lang = "bash";
        };
        lua = {
          pattern = "^:%s*lua%s+";
          icon = "";
          lang = "lua";
        };
        help = {
          pattern = "^:%s*he?l?p?%s+";
          icon = "Help ";
        };
        input = {};
      };
    };
    #commands = {
    #};
    #format = {
    #};

    notify = {
      enabled = true;
      #view = "notify";
      #stages = "slide"; # stages: fade_in_slide_out | fade | slide | static
    };

    lsp = {
      documentation = {
        #opts = {};
        view = "hover";
      };
      hover = {
        enabled = true;
        #opts = {};
        #view = null;
      };
      message = {
        enabled = true;
        view = "notify";
        #opts = {};
      };
      progress = {
        enabled = true;
        view = "mini";
      };
      signature = {
        enabled = true;
        autoOpen = {
          enabled = true;
          trigger = true;
          luasnip = true;
        };
        #view = null;
        #opts = {};
      };
      override = {};
      # Open long messages in split instead of notify UI
    };

    popupmenu = {
      enabled = true;
      backend = "nui"; # (nui | cmp)
    };

    presets = {
      bottom_search = true; # Search line @ bottom
      #command_palette = true; # Command line @ top-center
      inc_rename = true;
      long_message_to_split =
        true; # Open long msgs in split instead of notify UI
      lsp_doc_border = true; # hover docs & signature help border
    };
    redirect = {view = "popup";};
  };
}
# --- Noice.nvim -------------------
# https://github.com/folke/noice.nvim
#
# Alternate UI for Neovim. Completely replaces cmdline, messages, popupmenu
#
# - Treesitter requires parsers: vim, regex, lua, bash, markdown, markdown_inline
# - Views are combination of: backend + options
#
# +--View----------+--Backend----+--Like------------------+--Options-|-Description----------------------------+
# | notify         | notify      | nvim-notify            | { title, level, replace=false, merge=false }      |
# | split          | split       | nui.nvim               | {                                size=auto,       |
# | vsplit         | split       | nui.nvim               |                          position=auto,           |
# | popup          | popup       | nui.nvim               | win_options.winhighlight.<hl-group>=<hl-group> }  |
# | mini           | mini        | notifier/fidget.nvim   | Default position: bottom-right                    |
# | cmdline        | popup       | cmdline                | Similar to native cmdline, bottom line            |
# | cmdline_popup  | popup       | Fancy cmdline popup    | Diff styles according to cmdline mode             |
# | cmdline_output | split       | presets.cmdline_output_to_split |                                          |
# | messages       | split       | Split `:messages`      |                                                   |
# | confirm        | popup       | Popup: `confirm` event |                                                   |
# | hover          | popup       | Popup: LSP Signature   | Popup for help / hover                            |
# | popupmenu      | nui.menu    | popupmenu.backend=nui  | Special popupmenu w render options if backend=nui |
# |                | virtualtext | Message: virtualtext   | (ex:search_count) {hl_group=<hl-group>}           |
# |                | notify_send | Desktop notification   |                                                   |
# +---------------------------+-------------------------------------------------------------------------------+
# |
# +--Formatters--+
# | level    | <level>=
# | text     |
# | message  |
# | progress |
# | title    |
# | event    |
# | kind     |
# | date     |
# | confirm  |
# | cmdline  |
# | spinner  |
# | data     |
