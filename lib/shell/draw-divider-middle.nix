{pkgs, ...}: let
  mkLine = import ./draw-line.nix {inherit pkgs;};
in
  mkLine "" "├" "─" "┤"
