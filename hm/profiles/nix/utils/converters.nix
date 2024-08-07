{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    # --- Package Converters ---
    pkgs.bundix # Ruby gemfile bundler
    pkgs.buildkit-nix # Convert Nix to Dockerfile
    pkgs.cabal2nix # Cabal files
    pkgs.crate2nix # Rust crate
    pkgs.crystal2nix # Crystal shard.lock
    pkgs.dconf2nix # GNOME Settings
    pkgs.deadnix # Find unused code
    pkgs.elm2nix # Elm
    #pkgs.go2nix # Go apps packaging for Nix (Archived upstream)
    pkgs.mix2nix # Generate Nix expressions from mix.lock
    pkgs.nc4nix # Packaging helper for Nextcloud apps
    pkgs.node2nix # Generate Nix expressions to build NPM packages
    #pkgs.pypi2nix # PyPi package to Nix (removed: unmaintained)
    pkgs.rnix-hashes # Nix hash converter
    #pkgs.setupcfg2nix # Python setup.cfg
    pkgs.yarn2nix # Convert packages.json & yarn.lock To Nix expression that downloads all deps
    pkgs.nur.repos.ethancedwards8.firefox-addons-generator

    # --- Config Converters ---
    pkgs.terranix # NixOS-like Terraform JSON generator
    pkgs.toml2nix # Convert TOML configs to Nix

    # --- Asset Converters ---
    pkgs.iconConvTools # Tools for icon conversion specific to Nix package manager

  ];

}
