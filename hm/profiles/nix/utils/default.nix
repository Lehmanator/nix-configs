{ inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ./converters.nix
    ./direnv.nix
    #./cli.nix
    #./devshell.nix
    #./diff.nix
    ./docs.nix
    #./editor.nix
    ./nix-alien.nix
    #./nix-index.nix
    #./plugins.nix
    ./updaters.nix
  ];
  home.packages = let sys = pkgs.stdenv.system; in with inputs; [
    # TODO: Add more utils
    # TODO: Add package conversion utils
    # TODO: Add config format conversion utils

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
