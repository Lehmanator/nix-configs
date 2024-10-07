{ ... }@args:
let
  draw-line = import ./draw-line.nix args;
in
{ top    = draw-line "" "╭" "─" "╮";
  middle = draw-line "" "├" "─" "┤";
  bottom = draw-line "" "╰" "─" "╯";
}
