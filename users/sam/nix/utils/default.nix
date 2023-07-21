{ inputs, self
, config, lib, pkgs
, ...
}:
{

  imports = [
    ./converters.nix
    ./direnv.nix
    ./nix-alien.nix
    ./nix-index.nix
    ./updaters.nix
  ];
  home.packages = [

    # --- Documentation ------
    pkgs.manix # Nix documentation CLI
    pkgs.nix-doc # Nix documentation CLI

    # --- Diffs ---
    pkgs.nvd # Nix version diff tool
    pkgs.niff # Compares two Nix expressions & determines what attributes changed

    # --- Nix Plugins --------
    pkgs.nix-plugins # Extensions for Nix

    # --- Package Fixers ---
    pkgs.flockit # LD_PRELOAD shim to add file locking to programs that don't do it (I'm looking at you, rsync!)

    # --- CLIs ---
    pkgs.nox # Cleaner CLI
    pkgs.nux # Wrapper over Nix CLI

    # TODO: Add more utils
    # TODO: Add package conversion utils
    # TODO: Add config format conversion utils

    # --- Benchmarking ---
    pkgs.unixbench
    pkgs.phoronix-test-suite

    # --- Editors ---
    # TODO: Move to ${self}/users/sam/editors/default.nix
    pkgs.alejandra # Nix code formatter
    #pkgs.nil # Language server
    pkgs.statix # Linting & suggestions
    pkgs.vimPlugins.statix # Use statix in vim

    # --- Shell ---
    # TODO: Move to ${self}/users/sam/shell/default.nix
    pkgs.any-nix-shell

  ];

}
