{ inputs, config, lib, pkgs, ... }@moduleArgs:
let
  # TODO: Use lib.strings.replicate N "mystring"
  draw-divider = import "${inputs.self}/lib/shell/draw-divider.nix" moduleArgs;
  mkWrapper    = import "${inputs.self}/lib/shell/wrap-command-box.nix" moduleArgs;
  mkLine       = import "${inputs.self}/lib/shell/draw-line.nix" moduleArgs;
  mkTop = draw-divider.top;
  mkBot = draw-divider.bottom;
  mkMid = draw-divider.middle;

  figlet = lib.getExe pkgs.figlet;
  sed    = lib.getExe pkgs.gnused;
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
          ${figlet} '${config.networking.hostName}' -f o8 -w "$(( COLUMNS - 1 ))" | \
          ${sed} 's/^/│ /'
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
        "usrbinenv"
        # "update-diff"
      ];
      text = mkBot;
    };
  };
}
