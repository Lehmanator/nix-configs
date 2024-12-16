{ config, lib, pkgs, ... }:
{
  imports = [./json.nix];

  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {

    # TODO: Split this file into parts? (nodejs, react, react-native, svelte, tailwindcss, vue)
    extraPackages = [
      pkgs.nodePackages_latest.prettier
      pkgs.tree-sitter-grammars.tree-sitter-html
      pkgs.tree-sitter-grammars.tree-sitter-javascript
      pkgs.tree-sitter-grammars.tree-sitter-jsdoc
      pkgs.typescript-language-server
      pkgs.vscode-js-debug
    ];
  };

  # --- Neovim ---
  # pkgs.nodePackages_latest.coc-prettier
  # pkgs.vimPlugins.vim-prettier

  # --- VSCode ---
  # pkgs.vscode-extensions.esbenp.prettier-vscode

  # --- Zed ------
  programs.zed-editor.extensions = ["ejs"];

  # --- Packages -----------------------------------------------------
  home.packages = [ ];
}
