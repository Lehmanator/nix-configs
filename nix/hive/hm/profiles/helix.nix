{ config, lib, pkgs, ... }: {
  programs.helix = {
    enable = true;
    #defaultEditor = true;

    # TODO: Move to ./helix/ignores.nix
    # TODO: Share .gitignore from programs.git.ignores
    #ignores =[
    #  ".build/"
    #  "!.gitignore"
    #];

    # TODO: Move to ./helix/<lang>/
    # TODO: Split into ./helix/<langName>/{lsp,dap,treesitter,formatter,default}.nix
    # https://docs.helix-editor.com/languages.html
    #languages = {};

    # https://docs.helix-editor.com/configuration.html
    settings = {
      # TODO: Split into ./helix/{completion,ui}.nix
      editor = {
        auto-completion = true;
        auto-format = true;
        auto-info = true;
        auto-save = false;
        bufferline = "multiple";
        color-modes = true;
        completion-replace = true;
        completion-timeout = 250;
        completion-trigger-len = 2;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        cursorline = true;
        gutters.layout = [ "diagnostics" "spacer" "line-numbers" "spacer" "diff" ];
        idle-timeout = 250;
        indent-guides = {
          render = true;
          skip-levels = 2;
        };
        insert-final-newline = false;
        line-number = "relative";
        line-numbers.min-width = 2;
        lsp = {
          enable = true;
          auto-signature-help = true;
          display-inlay-hints = true;
          display-messages = true;
          display-signature-help-docs = true;
          goto-reference-include-declaration = true;
          snippets = true;
        };
        middle-click-paste = true;
        mouse = true;
        popup-border = "all";
        preview-completion-insert = true;
        smart-tab = {
          enable = true;
          supercede-menu = false;
        };
        soft-wrap = { enable = true; };
        statusline = {
          separator = "·"; #"|";
          mode = { insert = "insert"; normal = ""; select = "select"; };
          left = ["mode" "total-line-numbers" "spacer" "separator" "spacer" "file-name" "read-only-indicator" "file-modification-indicator" "file-encoding"];
          center = ["spinner" "spacer" "version-control" "spacer" "spacer" "diagnostics" "spacer" "workspace-diagnostics"];
          right = ["file-type" "separator" "register" "primary-selection-length" "separator" "position" "separator" "spacer" "position-percentage" "mode"];
        };
        text-width = 80;
        whitespace = {
          render = {
            nbsp = "all";
            newline = "none";
            nnbsp = "all";
            space = "none";
            tab = "all";
          };
        };
        workspace-lsp-roots = [ ];
      };

      # TODO: Move to ./helix/keys/{normal,insert,select,default}.nix
      keys = {
        insert = { esc = [ "collapse_selection" "normal_mode" ]; };
        normal = {
          "#" = [
            "move_char_right"
            "move_prev_word_start"
            "move_next_word_end"
            "search_selection"
            "search_prev"
          ];
          "$" = "goto_line_end";
          "%" = "match_brackets";
          "*" = [
            "move_char_right"
            "move_prev_word_start"
            "move_next_word_end"
            "search_selection"
            "search_next"
          ];
          "0" = "goto_line_start";
          C = [
            "extend_to_line_end"
            "yank_main_selection_to_clipboard"
            "delete_selection"
            "insert_mode"
          ];
          C-h = "select_prev_sibling";
          C-j = "shrink_selection";
          C-k = "expand_selection";
          C-l = "select_next_sibling";
          C-o = "file_picker"; #":config-open";
          C-r = ":config-reload";
          D = [
            "extend_to_line_end"
            "yank_main_selection_to_clipboard"
            "delete_selection"
          ];
          G = "goto_file_end";
          S = "surround_add";
          V = [ "select_mode" "extend_to_line_bounds" ];
          Y = [
            "extend_to_line_end"
            "yank_main_selection_to_clipboard"
            "collapse_selection"
          ];
          "^" = "goto_first_nonwhitespace";
          a = [ "append_mode" "collapse_selection" ];
          esc = [ "collapse_selection" "keep_primary_selection" ];
          ret = ["command_mode"];
          i = [ "insert_mode" "collapse_selection" ];
          j = "move_line_down";
          k = "move_line_up";
          u = [ "undo" "collapse_selection" ];
          y = {
            G = [
              "select_mode"
              "extend_to_line_bounds"
              "goto_last_line"
              "extend_to_line_bounds"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            W = [
              "move_next_long_word_start"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            down = [
              "select_mode"
              "extend_to_line_bounds"
              "extend_line_below"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            g = {
              g = [
                "select_mode"
                "extend_to_line_bounds"
                "goto_file_start"
                "extend_to_line_bounds"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
            };
            j = [
              "select_mode"
              "extend_to_line_bounds"
              "extend_line_below"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            k = [
              "select_mode"
              "extend_to_line_bounds"
              "extend_line_above"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            up = [
              "select_mode"
              "extend_to_line_bounds"
              "extend_line_above"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            w = [
              "move_next_word_start"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
              "normal_mode"
            ];
            y = [
              "extend_to_line_bounds"
              "yank_main_selection_to_clipboard"
              "normal_mode"
              "collapse_selection"
            ];
          };
          "{" = [ "goto_prev_paragraph" "collapse_selection" ];
          "}" = [ "goto_next_paragraph" "collapse_selection" ];
        };
        select = {
          "$" = "goto_line_end";
          "%" = "match_brackets";
          "0" = "goto_line_start";
          C = [ "goto_line_start" "extend_to_line_bounds" "change_selection" ];
          C-a = [ "append_mode" "collapse_selection" ];
          D = [ "extend_to_line_bounds" "delete_selection" "normal_mode" ];
          G = "goto_file_end";
          S = "surround_add";
          "^" = "goto_first_nonwhitespace";
          a = "select_textobject_around";
          esc = [ "collapse_selection" "keep_primary_selection" "normal_mode" ];
          i = "select_textobject_inner";
          j = [ "extend_line_down" "extend_to_line_bounds" ];
          k = [ "extend_line_up" "extend_to_line_bounds" ];
          tab = [ "insert_mode" "collapse_selection" ];
          "{" = [ "extend_to_line_bounds" "goto_prev_paragraph" ];
          "}" = [ "extend_to_line_bounds" "goto_next_paragraph" ];
        };
      };
      theme = "adwaita-dark";
    };
  };

  # TODO: Split into ./helix/themes/<themeName>.nix
  # https://docs.helix-editor.com/themes.html
  themes =
    let
      transparent = "none";
      gray = "#665c54";
      dark-gray = "#3c3836";
      white = "#fbf1c7";
      black = "#282828";
      red = "#fb4934";
      green = "#b8bb26";
      yellow = "#fabd2f";
      orange = "#fe8019";
      blue = "#83a598";
      magenta = "#d3869b";
      cyan = "#8ec07c";
    in
    {
      lehman-transparent = {
        "ui.statusline" = {
          fg = white;
          bg = transparent;
        };
        "ui.statusline.inactive" = {
          fg = dark-gray;
          bg = transparent;
        };
      };
    };

  package = pkgs.helix;

  # TODO: Split this config into ./helix/<langName>/{lsp,dap,treesitter,formatter,default}.nix
  # TODO: For all (favorite) languages, add their associated:
  # - [ ] LSP servers
  # - [ ] DAP
  # - [ ] Tree-sitter grammars
  # - [ ] Formatters
  extraPackages = lib.unique
    ((lib.flatten (builtins.attrValues pkgs.tree-sitter-grammars)) ++ [
      pkgs.ansible-language-server
      pkgs.arduino-language-server
      pkgs.asm-lsp
      #pkgs.awk-language-server
      pkgs.nodePackages.bash-language-server
      pkgs.beancount-language-server
      pkgs.bitbake-language-server
      pkgs.blueprint-compiler
      pkgs.buf-language-server
      #pkgs.cairo-language-server
      pkgs.ccls
      pkgs.clang-tools
      pkgs.clojure-lsp
      pkgs.cljfmt
      pkgs.cmake-language-server
      pkgs.coqPackages.coq-lsp
      pkgs.csharp-ls
      pkgs.cuelsp
      pkgs.dart
      pkgs.dhall-lsp-server
      pkgs.vscode-extensions.vscode-dhall-lsp-server
      pkgs.nodePackages.diagnostic-languageserver
      pkgs.docker-compose-language-service
      pkgs.dockerfile-language-server-nodejs
      pkgs.dot-language-service
      pkgs.elixir-ls
      pkgs.vscode-extensions.elixir-lsp.vscode-elixir-ls
      pkgs.elmPackages.elm-language-server
      pkgs.emmet-ls
      pkgs.emmet-language-server
      pkgs.erlang-ls
      pkgs.fennel-ls
      pkgs.fortls
      pkgs.fortran-language-server
      pkgs.glas
      pkgs.glsl_analyzer
      pkgs.glslls
      pkgs.gocode-gomod
      pkgs.godot3-debug-server
      pkgs.godot3-mono-debug-server
      pkgs.godot3-mono-server
      pkgs.godot3-server
      # pkgs.golangci-lint-langserver # Broken: 2024-05-29
      pkgs.gomarkdoc
      pkgs.gopls
      pkgs.gqlint
      #pkgs.graphql-lsp
      pkgs.haskell-language-server
      pkgs.helix-gpt
      pkgs.helm-ls
      pkgs.htmx-lsp
      pkgs.nodePackages.intelephense
      pkgs.javascript-typescript-langserver
      pkgs.jdt-language-server
      pkgs.jq-lsp
      pkgs.jsonnet-language-server
      pkgs.nodePackages.json-server
      pkgs.kakoune-lsp
      pkgs.kotlin-language-server
      pkgs.lemminx
      pkgs.lexical
      pkgs.llm-ls
      pkgs.ltex-ls
      pkgs.lua-language-server
      #pkgs.markdoc-ls
      pkgs.markdown-oxide
      pkgs.marksman
      pkgs.metals
      pkgs.millet
      pkgs.nginx-language-server
      pkgs.nil
      pkgs.nimlangserver
      pkgs.nimlsp
      pkgs.nixd
      pkgs.nls
      pkgs.ocamlPackages.ocaml-lsp
      pkgs.ols
      pkgs.openscad-lsp
      #pkgs.pasls
      pkgs.perlnavigator
      pkgs.phpactor
      #pkgs.pkgbuild-language-server
      pkgs.postgres-lsp
      pkgs.nodePackages.purescript-language-server
      pkgs.pypiserver
      pkgs.pythonPackages.jupyter-lsp
      pkgs.pythonPackages.jupyterlab-lsp
      pkgs.pythonPackages.pyls-flake8
      pkgs.pythonPackages.pyls-isort
      pkgs.pythonPackages.pylsp-mypy
      pkgs.pythonPackages.pylsp-rope
      pkgs.pythonPackages.python-lsp-black
      pkgs.pythonPackages.python-lsp-jsonrpc
      pkgs.pythonPackages.python-lsp-ruff
      pkgs.pythonPackages.python-lsp-server
      pkgs.ruff-lsp
      pkgs.ruby-lsp
      pkgs.regal
      pkgs.regols
      pkgs.roslyn-ls
      pkgs.rune-languageserver
      pkgs.rust-analyzer
      pkgs.scry
      pkgs.serve-d
      pkgs.slint-lsp
      pkgs.rubyPackages.solargraph
      pkgs.spectral-language-server
      pkgs.sourcekit-lsp
      pkgs.nodePackages.svelte-language-server
      pkgs.svls
      pkgs.tailwindcss-language-server
      pkgs.taplo
      pkgs.terraform-ls
      pkgs.terraform-lsp
      pkgs.texlab
      pkgs.tremor-language-server
      pkgs.ttags
      pkgs.nodePackages.typescript-language-server
      pkgs.typos-lsp
      pkgs.typst-lsp
      pkgs.vala-language-server
      pkgs.verible
      pkgs.vhdl-ls
      pkgs.vim-language-server
      pkgs.vscode-langservers-extracted
      #pkgs.vue-language-server
      pkgs.nodePackages.vls
      pkgs.nodePackages.unified-language-server

      pkgs.nodePackages.vscode-css-languageserver-bin
      pkgs.nodePackages.vscode-html-languageserver-bin
      pkgs.nodePackages.vscode-json-languageserver
      pkgs.yaml-language-server
      pkgs.zls

      # --- Treesitter Grammars ---
      pkgs.tree-sitter-grammars.tree-sitter-vue
      pkgs.vimPlugins.nvim-treesitter-parsers.cairo
      pkgs.vimPlugins.nvim-treesitter-parsers.awk
    ]);
}
