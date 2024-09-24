{ config, lib, pkgs, ... }: {
  imports = [
    ./converters.nix  # x2nix utils.
    ./docs.nix
    ./linters.nix
    ./misc.nix
    ./nix-alien.nix
    ./updaters.nix
    #./editor.nix
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
    pkgs.nox # Cleaner CLI (Unmaintained)

    # --- Shell ---
    # TODO: Move to ${self}/users/sam/shell/default.nix
    pkgs.any-nix-shell
    #pkgs.zsh-nix-shell
  ];
}
