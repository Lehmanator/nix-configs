{pkgs, ...}@args: let
  mkLine = import ./draw-line.nix args;
  # TODO: Wrap script w/  "| ${lib.getExe pkgs.gnused} 's/^/│ /'"
in
  msg: script: ''
    if [[ -e /run/current-system ]]; then
      ${mkLine "[${msg}]" "╭" "─" "╮"}
      ${script}
      ${mkLine "" "╰" "─" "╯"}
      echo
    fi
  ''
