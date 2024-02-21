{
  config,
  lib,
  pkgs,
  ...
}: let
  mkWrapper = import ../../../lib/shell/wrap-command-box.nix {inherit pkgs;};
  mkLine = import ../../../lib/shell/draw-line.nix {inherit pkgs;};
  mkTop = import ../../../lib/shell/draw-divider-top.nix {inherit pkgs;};
  mkBot = import ../../../lib/shell/draw-divider-bottom.nix {inherit pkgs;};
  mkMid = import ../../../lib/shell/draw-divider-middle.nix {inherit pkgs;};
in {
  system = {
    activationScripts = {
      aaa-begin = {
        deps = [];
        text =
          ''
            echo
          ''
          + mkWrapper "NixOS System Activation" ''
            echo '│ '
            ${pkgs.figlet}/bin/figlet 'NixOS:   ${config.networking.hostName}' -f o8 -w "$(( COLUMNS - 8 ))" | ${
              lib.getExe pkgs.gnused
            } 's/^/│ /'
          '';
      };
      aaa-end = {
        deps = ["aaa-begin"];
        text = mkMid;
      };
      zzz-begin = {
        deps = ["aaa-begin" "aaa-end" "diff-closures" "diff-versions"];
        text = mkMid;
      };
      zzz-end = {
        deps = ["aaa-begin" "aaa-end" "diff-closures" "diff-versions" "zzz-begin"];
        text = mkBot;
      };
    };
  };
}
