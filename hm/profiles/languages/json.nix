{ config, lib, pkgs, ... }:
let
  # NOTE: nodePackages_latest may not be in binary cache. Building nodejs takes a long time.
  latest = false;
  nodePackages = if latest then pkgs.nodePackages_latest else pkgs.nodePackages;
in
{
  home.packages = [
    pkgs.jnv
    pkgs.jql
    pkgs.jqp
  ];

  programs.helix.extraPackages = [
    pkgs.tree-sitter-grammars.tree-sitter-json
    pkgs.tree-sitter-grammars.tree-sitter-json5
    nodePackages.vscode-json-languageserver
  ];
  programs.zed-editor.extensions = [];
}
