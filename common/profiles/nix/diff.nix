{
  config,
  lib,
  pkgs,
  ...
}: let
  # TODO: grep, column, print, sort
  nix = lib.getExe config.nix.package;
  nix-diff = lib.getExe pkgs.nix-diff;
  choose = lib.getExe pkgs.choose;
  gawk = lib.getExe pkgs.gawk;
  rg = lib.getExe pkgs.ripgrep;
in {
  system.activationScripts = {
    diff-closures = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "╭───[Closure Diff]─────────────────────────────────────────╮"
          ${nix} store diff-closures /run/current-system "$systemConfig" | ${rg} -w "→" | ${rg} -w "KiB" | column --table --separator " ,:" | ${choose} 0:1 -4:-1 | ${gawk} '{s=$0; gsub(/\033\[[ -?]*[@-~]/,"",s); print s "\t" $0}' | sort -k5,5gr | ${choose} 6:-1 | column --table
          echo "╰──────────────────────────────────────────────────────────╯"
        fi
      '';
    };

    # https://github.com/nix-community/srvos/blob/main/nixos/common/upgrade-diff.nix
    diff-versions = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "╭───[diff to current-system]───────────────────────────────╮"
          ${
          lib.getExe pkgs.nvd
        } --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
          echo "╰──────────────────────────────────────────────────────────╯"
        fi
      '';
    };

    #diff-derivations = {
    #  supportsDryActivation = true;
    #  text = ''
    #    if [[ -e /run/current-system ]]; then
    #      echo "╭───[Diff: Nix Derivation]─────────────────────────────────╮"
    #      ${nix-diff} /run/current-system "$systemConfig" --skip-already-compared --word-oriented --squash-text-diff
    #      echo "╰──────────────────────────────────────────────────────────╯"
    #    fi
    #  '';
    #};
  };
  #system.userActivationScripts.nix-diff = {};

  # TODO: Save state of flake config dir from last build/activation, then diff the file tree.
  # TODO: Wrap `nix-diff` with shell script to discard extra args.
  # TODO: Set `nix-diff` wrapper script as `diff-hook` (`nix.settings.diff-hook`)
  nix.settings = {
    diff-hook = "${nix-diff}";
    run-diff-hook = true;
  };
}
