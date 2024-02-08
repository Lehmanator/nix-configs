{
  config,
  lib,
  pkgs,
  ...
}: let
  mkWrapper = import ../../../lib/shell/wrap-command-box.nix {inherit pkgs;};
in {
  # TODO: Save state of flake config dir from last build/activation, then diff the file tree.
  # TODO: pkgs.writeShellApplication ?
  nix.settings = {
    run-diff-hook = true;
    diff-hook = "${
      lib.getExe pkgs.nix-diff
    } --color always --skip-already-compared --word-oriented --squash-text-diff ";
    # mkWrapper "nix-diff"
  };

  system.activationScripts = {
    diff-closures = {
      supportsDryActivation = true;
      text = mkWrapper "nix store diff-closures" ''
        ${
          lib.getExe config.nix.package
        } store diff-closures /run/current-system "$systemConfig" | ${
          lib.getExe pkgs.ripgrep
        } --color=always -w "→" | ${
          lib.getExe pkgs.ripgrep
        } --color=always -w "KiB" | column --table --separator " ,:" | "${pkgs.choose}/bin/choose" 0:1 -4:-1 | ${
          lib.getExe pkgs.gawk
        } '{s=$0; gsub(/\0 33\[[ -?]*[@-~]/,"",s); print s "\t" $0}' | sort -k5,5gr | "${pkgs.choose}/bin/choose" 6:-1 | column --table | ${
          lib.getExe pkgs.gnused
        } 's/^/│ /'
      '';
    };

    # https://github.com/nix-community/srvos/blob/main/nixos/common/upgrade-diff.nix
    diff-versions = {
      supportsDryActivation = true;
      text = mkWrapper "nvd diff" ''
        ${
          lib.getExe pkgs.nvd
        } --color always --nix-bin-dir ${config.nix.package}/bin diff /run/current-system "$systemConfig" | ${
          lib.getExe pkgs.gnused
        } 's/^/│ /'
      '';
    };

    #diff-derivations = {
    #  supportsDryActivation = true;
    #  text = mkWrapper "nix-diff" ''
    #    ${
    #      lib.getExe pkgs.nix-diff
    #    } /run/current-system "$systemConfig" --skip-already-compared --word-oriented --squash-text-diff --color always
    #  '';
    #};
  };
  #system.userActivationScripts.nix-diff = {};
}
