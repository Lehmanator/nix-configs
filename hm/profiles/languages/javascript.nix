{ config, lib, pkgs, ... }:
let
  # NOTE: nodePackages_latest may not be in binary cache. Building nodejs takes a long time.
  latest = false;
  nodePackages = if latest then pkgs.nodePackages_latest else pkgs.nodePackages;
in
{
  imports = [./json.nix];

  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {

    # TODO: Split this file into parts? (nodejs, react, react-native, svelte, tailwindcss, vue)
    extraPackages = [
      nodePackages.prettier
      pkgs.tree-sitter-grammars.tree-sitter-html
      pkgs.tree-sitter-grammars.tree-sitter-javascript
      pkgs.tree-sitter-grammars.tree-sitter-jsdoc
      pkgs.typescript-language-server
      pkgs.vscode-js-debug
    ];
  };

  # --- Neovim ---
  # nodePackages.coc-prettier
  # pkgs.vimPlugins.vim-prettier

  # --- VSCode ---
  # pkgs.vscode-extensions.esbenp.prettier-vscode

  # --- Zed ------
  programs.zed-editor.extensions = ["ejs"];

  # --- Packages -----------------------------------------------------
  home.packages = [ ];
}
