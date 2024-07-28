{ inputs, config, lib, pkgs, ... }: {
  imports = [
    #./cli.nix
    ./converters.nix
    ./direnv.nix
    #./devshell.nix
    #./diff.nix
    ./docs.nix
    #./editor.nix
    ./linters.nix
    ./manix.nix
    ./misc.nix
    ./nix-alien.nix
    #./nix-index.nix
    #./plugins.nix
    ./updaters.nix
  ];

  # TODO: Add more utils
  # TODO: Add package conversion utils
  # TODO: Add config format conversion utils
  home.packages = [
    # --- Nix Plugins --------
    pkgs.nix-plugins # Extensions for Nix

    # --- Package Fixers ---
    pkgs.flockit # LD_PRELOAD shim to add file locking to programs that don't do it (I'm looking at you, rsync!)

    # --- CLIs ---
    pkgs.nox # Cleaner CLI
    pkgs.nux # Wrapper over Nix CLI

    # --- Benchmarking ---
    pkgs.unixbench
    pkgs.phoronix-test-suite

    # --- Shell ---
    # TODO: Move to ${self}/users/sam/shell/default.nix
    pkgs.any-nix-shell
    #pkgs.zsh-nix-shell
  ];
}
