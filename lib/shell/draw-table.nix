{ ... }@args: let
  mkLine = (import ./draw-line.nix args);
  # ⛖  ⛗
  chars = {
    arrows = {
      left = "←"; up = "↑"; right = "→"; down = "↓";
      left-right="↔"; up-down="↕";
      nw="↖"; ne="↗"; se="↘"; sw="↙";
    };
    diagnostic = {
      warning = "⚠";
      voltage = "⚡";
      atom = "⚛";
      setting = "⚙";
      error = "✕";
    };
    misc = {
      star-filled = "★";
      star-outline = "☆";
    };
  };
  diff-commands = {
    closures = {
      base = "nix store diff-closures";
      full = ''
        nix store diff-closures /nix/var/nix/profiles/system-796-link /nix/var/nix/profiles/system-797-link | rg --color=always -w "→" | rg --color=always -w "KiB" | column --table --separator " ,:" | choose 0:1 -4:-1 | gawk '{s=$0; gsub(/\0 33\[[ -?]*[@-~]/,"",s); print s "\t" $0}' | sort -k5,5gr | choose 6:-1 | column --table | sed 's/^/│ /'
      '';
      separators = [": " " →" ", "];
      symbols = {
        none = "∅";
        noop = "ε";
      };
    };
    nvd = {
      base = "nvd diff";
      args = lib.cli.toGNUCommandLineShell {
        color = "always";
        nix-bin-dir = "<path>";
        root = "<store-path>";
        selected = true;
      } + "<name-pattern>";
      separators = [ ".] " " " "\t" " -> "];
      replace = {
        "A" = "+";
        "R" = "-";
        "C" = "~";
        "D" = "";
        "U" = "";
      };
    };
  };
in { ... }@columnNames:
# name=str
# trunc
# right
# width=int
# strictwidth
# noextreme
# wrap
# hide
# json="string" | "number" | "boolean"
  ''
    column \
      --output-separator "│"
      --table \
      --table-column name=Action,left,width=5,
      --table-column name=Number,left,width=5,
      --table-column name=Package,left,width=50,
      --table-column name=Old,left,width=50,
      --table-column name=New,left,width=50,
      --separator " ,:"
      --output-separator "";
  ''
  mkLine "" "╭" "─" "╮"
