{ inputs, config, lib, pkgs, ... }:
{

  # https://github.com/mozilla/nixpkgs-mozilla
  # https://github.com/colemickens/flake-firefox-nightly
  home.packages = [
    inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin  # TODO: Add to inputs in flake.nix
  ];

  programs.firefox.package = inputs.firefox.packages.${pkgs.system}.firefox-bin;
}
