{ inputs, config, lib, pkgs, ... }: {
  home.packages = [
    # --- Nix Plugins --------
    pkgs.nix-doc     # Nix documentation CLI
    pkgs.nix-plugins # Extensions for Nix

    # --- Package Fixers ---
    pkgs.flockit     # LD_PRELOAD shim to add file locking to programs that dont supoort (e.g. rsync)

    # --- CLIs ---
    pkgs.nox                   # Cleaner Nix CLI (Unmaintained)
    pkgs.nvd                   # Nix version diff util
    pkgs.niff                  # Compare Nix exprs & determines what attrs changed.
    pkgs.nix-du                # Show sizes of Nix store paths
    pkgs.nix-init              # Generate packages from URLs
    pkgs.nix-tree              # Interactively view dep graphs of Nix derivations
    pkgs.nix-query-tree-viewer # GUI to view Nix store path deps
    pkgs.pre-commit            # Git pre-commit hooks

    # --- Linters ---
    # TODO: Nix LSP
    pkgs.alejandra             # Nix code linter
    pkgs.deadnix               # Find dead code in Nix configs
    pkgs.statix                # Nix static analysis
    pkgs.vulnix                # Nix(OS) vulnerability scanner

    # --- Updaters ---
    pkgs.niv        # Nix project dependency management
    pkgs.nix-init   # Auto create Nix package definitions from git repos
    pkgs.nix-update # Update Nix package version/source/hash to latest
    pkgs.nurl       # Auto generate fetcher expressions from URLs
    pkgs.nvfetcher  # Update Nix resource commits & hashes
    pkgs.pr-tracker # Nixpkgs pull request channel tracker
    pkgs.update-nix-fetchgit
    inputs.fast-flake-update.packages.${pkgs.stdenv.system}.default
    #pkgs.nixpkgs-update

    # --- Shell ---
    # TODO: Move to ${inputs.self}/hm/users/sam/shell/default.nix
    pkgs.any-nix-shell
    #pkgs.zsh-nix-shell

    # --- Package Converters ---
    pkgs.bundix        # Ruby gemfile bundler
    pkgs.buildkit-nix  # Convert Nix to Dockerfile
    pkgs.cabal2nix     # Cabal files
    pkgs.crate2nix     # Rust crate
    pkgs.crystal2nix   # Crystal shard.lock
    pkgs.dconf2nix     # GNOME Settings
    pkgs.elm2nix       # Elm
    #pkgs.go2nix       # Go apps packaging for Nix (Archived upstream)
    pkgs.mix2nix       # Generate Nix expressions from mix.lock
    pkgs.nc4nix        # Packaging helper for Nextcloud apps
    pkgs.node2nix      # Generate Nix expressions to build NPM packages
    #pkgs.pypi2nix     # PyPi package to Nix (removed: unmaintained)
    pkgs.rnix-hashes   # Nix hash converter
    #pkgs.setupcfg2nix # Python setup.cfg
    pkgs.yarn2nix      # packages.json & yarn.lock -> Nix expr w/ deps downloaded
    pkgs.nur.repos.ethancedwards8.firefox-addons-generator

    # --- Config Converters ---
    pkgs.terranix      # NixOS-like Terraform JSON generator
    pkgs.toml2nix      # Convert TOML configs to Nix

    # --- Asset Converters ---
    pkgs.iconConvTools # Tools for icon conversion specific to Nix package manager
  ];
}
