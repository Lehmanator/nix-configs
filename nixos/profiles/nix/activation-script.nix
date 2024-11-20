{ inputs, config, lib, pkgs, ... }@moduleArgs:
let
  hasNerdFont = true;  #    󱄅   

  # TODO: Use lib.strings.replicate N "mystring"
  draw-divider = import "${inputs.self}/lib/shell/draw-divider.nix" moduleArgs;
  mkWrapper    = import "${inputs.self}/lib/shell/wrap-command-box.nix" moduleArgs;
  mkLine       = import "${inputs.self}/lib/shell/draw-line.nix" moduleArgs;
  mkTop = draw-divider.top;
  mkBot = draw-divider.bottom;
  mkMid = draw-divider.middle;
  figlet-bin = "${pkgs.figlet}/bin/figlet";
  figlet-args = "${config.networking.hostName} -f o8 -w \"(( COLUMNS - 1 ))\"";
  figlet = figlet-bin + " " + figlet-args;
  sed    = lib.getExe pkgs.gnused;
  boxes  = lib.getExe pkgs.boxes;
  # https://boxes.thomasjensen.com/config-syntax.html
  boxes-cfg = ''
    BOX ansi-rounded-title, title-box-round
      author "Sam Lehman <git@samlehman.dev>"
      designer "Sam Lehman <git@samlehman.dev>"
      tags ("simple" "unicode")
      SAMPLE
          +-----------+
          | Yolo      |
          +-----------+
      END
      SHAPES {
        n ("", "")
        w ("")
        s ("")
        e ("")
        nw ("")
        nnw ("")
        wnw ("")
      }
      PADDING {
        all 1
        horizontal 2
        vertical 1
        top 0
      }
      # DELIMITER \'
      ELASTIC ("n" "s" "e" "w")
      REPLACE "" WITH ""
      REVERSE "" TO   ""
    END ansi-rounded-title
    END
    PARENT ${pkgs.boxes}/share/boxes/boxes-config
  '';
in {
  system.activationScripts = {
    aaa-begin = {
      deps = [];
      # FIXME: Double-width strings breaks character count
      text = mkWrapper "${lib.optionalString hasNerdFont " ]─["}NixOS System Activation" ''

        ${figlet} | ${boxes} --design ansi-rounded
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
      # TODO: sops-install-secrets, setting up /etc..., reloading user units for user..., restarting sysinit-reactivation.target
      text = mkBot;
      deps = [
        "aaa-begin" "aaa-end" "diff-closures" "diff-versions" "zzz-begin"
        "etc" "groups" "hashes" "setupSecrets"
        "usrbinenv" # "update-diff"
      ];
    };
  };
}
