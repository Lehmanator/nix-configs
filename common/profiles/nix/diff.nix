{ config
, lib
, pkgs
, ...
}: {
  environment.systemPackages = [ pkgs.nix-diff pkgs.nix-output-monitor pkgs.expect ];
  environment.shellAliases.nom-rebuild = "unbuffer nixos-rebuild $@ |& nom";

  #system.userActivationScripts.nix-diff = {};
  system.activationScripts = {
    #diff-derivations = {
    #  supportsDryActivation = true;
    #  text = ''
    #    if [[ -e /run/current-system ]]; then
    #      echo "--- Nix derivation diff ---------------"
    #      ${pkgs.nix-diff}/bin/nix-diff /run/current-system "$systemConfig" --skip-already-compared --word-oriented --squash-text-diff
    #      echo "---------------------------------------"
    #    fi
    #  '';
    #};
    diff-closures = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "--- Closure Diff ----------------------"
          echo -e "\n***            ***          ***           ***           ***\n"
          ## ----- ORIG --- ${pkgs.nix}/bin/nix
          ${config.nix.package}/bin/nix store diff-closures /run/current-system "$systemConfig" | grep -w "→" | grep -w "KiB" | column --table --separator " ,:" | ${pkgs.choose}/bin/choose 0:1 -4:-1 | ${pkgs.gawk}/bin/awk '{s=$0; gsub(/\033\[[ -?]*[@-~]/,"",s); print s "\t" $0}' | sort -k5,5gr | ${pkgs.choose}/bin/choose 6:-1 | column --table
          echo -e "\n***            ***          ***           ***           ***\n"
          echo "---------------------------------------"
        fi
      '';
    };
    # https://github.com/nix-community/srvos/blob/main/nixos/common/upgrade-diff.nix
    diff-versions = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "--- diff to current-system ------------"
          ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
          echo "---------------------------------------"
        fi
      '';
    };
  };

  # TODO: Wrap `nix-diff` with shell script to discard extra args.
  # TODO: Set `nix-diff` wrapper script as `diff-hook` (`nix.settings.diff-hook`)
  nix.settings = {
    diff-hook = "${pkgs.nix-diff}/bin/nix-diff";
    run-diff-hook = true;
  };

  # TODO: Save state of flake config dir from last build/activation, then diff the file tree.
  #
}
