{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {

    # TODO: Split this file into parts?
    extraPackages = [
      pkgs.dockerfile-language-server-nodejs
      pkgs.nodePackages_latest.prettier
      pkgs.nodePackages_latest.vscode-json-languageserver
      pkgs.svelte-language-server
      pkgs.tailwindcss-language-server
      pkgs.tree-sitter-grammars.tree-sitter-html
      pkgs.tree-sitter-grammars.tree-sitter-javascript
      pkgs.tree-sitter-grammars.tree-sitter-jsdoc
      pkgs.tree-sitter-grammars.tree-sitter-json
      pkgs.tree-sitter-grammars.tree-sitter-json5
      pkgs.typescript-language-server
      pkgs.vscode-js-debug
      pkgs.vue-language-server
    ];
  };

  # --- Neovim ---
  # pkgs.nodePackages_latest.coc-prettier
  # pkgs.vimPlugins.vim-prettier

  # --- VSCode ---
  # pkgs.vscode-extensions.esbenp.prettier-vscode

  # --- Zed ------
  programs.zed-editor.extensions = ["svelte" "vue" "ejs"];

  # --- Packages -----------------------------------------------------
  home.packages = [
  ];
}
