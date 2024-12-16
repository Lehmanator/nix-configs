{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.jnv
    pkgs.jql
    pkgs.jqp
  ];

  programs.helix.extraPackages = [
    pkgs.tree-sitter-grammars.tree-sitter-json
    pkgs.tree-sitter-grammars.tree-sitter-json5
    pkgs.nodePackages_latest.vscode-json-languageserver
  ];
  programs.zed-editor.extensions = [];
}
