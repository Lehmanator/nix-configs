{pkgs, ...}: let
  mkLine = import ./draw-line.nix {inherit pkgs;};
in
  msg: script: ''
    if [[ -e /run/current-system ]]; then
      ${mkLine "[${msg}]" "╭" "─" "╮"}
      ${script}
      ${mkLine "" "╰" "─" "╯"}
      echo
    fi
  ''
