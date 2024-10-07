{ inputs, config, lib, pkgs, ... }@moduleArgs:
let
  # TODO: Use lib.strings.replicate N "mystring"
  importLib = name: import "${inputs.self}/lib/${name}.nix" moduleArgs;
  mkWrapper = importLib "shell/wrap-command-box";
  mkLine    = importLib "shell/draw-line";
  mkTop     = importLib "shell/draw-divider-top";
  mkBot     = importLib "shell/draw-divider-bottom";
  mkMid     = importLib "shell/draw-divider-middle";

  # mkWrapper = import ../../../lib/shell/wrap-command-box.nix    moduleArgs;
  # mkLine    = import ../../../lib/shell/draw-line.nix           moduleArgs;
  # mkTop     = import ../../../lib/shell/draw-divider-top.nix    moduleArgs;
  # mkBot     = import ../../../lib/shell/draw-divider-bottom.nix moduleArgs;
  # mkMid     = import ../../../lib/shell/draw-divider-middle.nix moduleArgs;
in {
  system.activationScripts = {
    aaa-begin = {
      deps = [];
      text =
        ''
          echo
        ''
        + mkWrapper "NixOS System Activation" ''
          echo '│ '
          ${pkgs.figlet}/bin/figlet '${config.networking.hostName}' -f o8 -w "$(( COLUMNS - 1 ))" | ${
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

      # TODO: sops-install-secrets, setting up /etc..., reloading user units for user..., restarting sysinit-reactivation.target
      deps = [
        "aaa-begin" "aaa-end" "diff-closures" "diff-versions" "zzz-begin"
        "etc" "groups" "hashes" "setupSecrets"
        # "update-diff"
        "usrbinenv"
      ];
      text = mkBot;
    };
  };
}
