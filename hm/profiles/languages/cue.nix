{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    extraPackages = [
      pkgs.cue
      pkgs.cuelsp
      pkgs.tree-sitter-grammars.tree-sitter-cue
    ];
  };

  # --- Neovim ---
  # pkgs.vimPlugins.nvim-treesitter-parsers.cue

  # --- VSCode ---
  # pkgs.vscode-extensions.asdine.cue

  # --- Zed ------
  programs.zed-editor.extensions = ["cue"];

  # --- Packages -----------------------------------------------------
  home.packages = [
    pkgs.cue
    pkgs.cuetsy
    pkgs.cuetools
  ];

}
