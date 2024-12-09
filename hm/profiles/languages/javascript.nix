{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {

    # TODO: Split this file into parts?
    extraPackages = [
      pkgs.vscode-js-debug
      pkgs.tree-sitter-grammars.tree-sitter-html
      pkgs.tree-sitter-grammars.tree-sitter-javascript
      pkgs.tree-sitter-grammars.tree-sitter-jsdoc
      pkgs.tree-sitter-grammars.tree-sitter-json
      pkgs.tree-sitter-grammars.tree-sitter-json5
      pkgs.typescript-language-server
      pkgs.tailwindcss-language-server
      pkgs.vue-language-server
      pkgs.dockerfile-language-server-nodejs
      pkgs.nodePackages_latest.vscode-json-languageserver
      pkgs.svelte-language-server
    ];
  };

  # --- Neovim ---
  # --- VSCode ---
  # pkgs.vscode-extensions.mads-hartmann.bash-ide-vscode

  # --- Zed ------
  programs.zed-editor.extensions = [];

  # --- Packages -----------------------------------------------------
  home.packages = [
  ];
}
