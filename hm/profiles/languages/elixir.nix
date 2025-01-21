{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.elixir
    pkgs.ex_doc
    pkgs.lexical
    pkgs.mix2nix
    pkgs.vimPlugins.elixir-tools-nvim
    pkgs.vimPlugins.nvim-treesitter-parsers.elixir
    pkgs.vscode-extensions.elixir-lsp.vscode-elixir-ls
    pkgs.vscode-extensions.stefanjarina.vscode-eex-snippets
  ];

  programs.helix.extraPackages = [
    pkgs.elixir_ls
    pkgs.tree-sitter-grammars.tree-sitter-elixir
  ];
  programs.zed-editor.extensions = [];

}
