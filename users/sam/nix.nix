{ self
, inputs
, overlays
, packages
, modules
, templates
, config
, lib
, pkgs
, ...
}:
# TODO: Write this config to       /etc/nix/nix.conf
# TODO: Write this config to  ~/.config/nix/nix.conf
# TODO: Write nix.registry to ~/.config/nix/registry.json
# TODO: Merge this config with equivalent from NixOS profile ( ${self}/profiles/nix.nix )
{
  imports = [
  ];

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  home.sessionVariables.NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  #nix.settings.plugin-files = [
  #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
  #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
  #];

  nix.settings.accept-flake-config = true;
  nix.extraOptions = ''
    use-xdg-base-directories = true;
  '';

  home.packages = [

    # --- Documentation ------
    pkgs.manix # Nix documentation CLI
    pkgs.nix-doc # Nix documentation CLI

    # --- Diffs ---
    pkgs.nvd # Nix version diff tool
    pkgs.niff # Compares two Nix expressions & determines what attributes changed

    # --- Nix Plugins --------
    pkgs.nix-plugins # Extensions for Nix

    # --- Package Updaters ---
    pkgs.niv # Nix project dependency management
    pkgs.nix-init # Automatically create Nix package definitions from git repos
    pkgs.nix-update # Updates versions/source/hashes of Nix packages to latest
    #pkgs.nixpkgs-update
    pkgs.nurl # Automatically generate fetcher expressions from URLs
    pkgs.nvfetcher # Update Nix resource commits & hashes
    pkgs.pr-tracker # Nixpkgs pull request channel tracker

    # --- Package Fixers ---
    pkgs.flockit # LD_PRELOAD shim to add file locking to programs that don't do it (I'm looking at you, rsync!)

    # --- Package Converters ---
    pkgs.bundix # Ruby gemfile bundler
    pkgs.buildkit-nix # Convert Nix to Dockerfile
    pkgs.cabal2nix # Cabal files
    pkgs.crate2nix # Rust crate
    pkgs.crystal2nix # Crystal shard.lock
    pkgs.dconf2nix # GNOME Settings
    pkgs.deadnix # Find unused code
    pkgs.dep2nix # Convert Gopkg.lock to deps.nix
    pkgs.elm2nix # Elm
    pkgs.go2nix # Go apps packaging for Nix
    pkgs.mix2nix # Generate Nix expressions from mix.lock
    pkgs.nc4nix # Packaging helper for Nextcloud apps
    pkgs.node2nix # Generate Nix expressions to build NPM packages
    pkgs.pypi2nix # PyPi package to Nix
    pkgs.rnix-hashes # Nix hash converter
    pkgs.setupcfg2nix # Python setup.cfg
    pkgs.yarn2nix # Convert packages.json & yarn.lock To Nix expression that downloads all deps

    # --- Config Converters ---
    pkgs.terranix # NixOS-like Terraform JSON generator
    pkgs.toml2nix # Convert TOML configs to Nix

    # --- Asset Converters ---
    pkgs.iconConvTools # Tools for icon conversion specific to Nix package manager

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
    pkgs.nil # Language server
    pkgs.statix # Linting & suggestions
    pkgs.vimPlugins.statix # Use statix in vim

    # --- Shell ---
    # TODO: Move to ${self}/users/sam/shell/default.nix
    pkgs.any-nix-shell
    pkgs.lorri
  ];
}
