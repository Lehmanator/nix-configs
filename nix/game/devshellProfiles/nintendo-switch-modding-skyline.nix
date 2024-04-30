{
  inputs,
  cell,
  pkgs,
  config,
  lib,
  ...
}:
#let
#  #  pkgs = inputs.nixpkgs;
#
#  rustToolchainOverlay = (final: prev: {
#    rustToolcahin =
#      let
#        rust = prev.rust-bin;
#      in
#      if builtins.pathExists ./rust-toolchain.toml then
#        rust.fromRustupToolchainFile ./rust-toolchain.toml
#      else if builtins.pathExists ./rust-toolchain then
#        rust.fromRustupToolchainFile ./rust-toolchain
#      else
#        rust.stable.latest.default.override {
#          extensions = [ "rust-src" "rustfmt" ];
#        };
#  })
#in
{
  # mozilla/nixpkgs-mozilla only provides overlays, not packages :(
  #  so we overlay them onto nixpkgs here.
  # TODO: Build pkgs from overlays? (use `blockTypes.pkgs`?)
  #_module.args.pkgs = import inputs.nixpkgs {
  #  inherit system;
  #  config.allowUnfree = true;
  #  overlays = [
  #    nur.overlay
  #    nixpkgs-mozilla.overlays.rust
  #  ];
  #};

  #commands = [{name=""; help=""; category=""; command="";}];
  #env = [{name=""; value="";}];

  packages =
    [
      pkgs.ryujinx
      pkgs.yuzu-mainline

      #cell.packages.cargo-skyline
      #cell.packages.skyline-arena-latency-slider
      #cell.packages.skyline-less-delay
      #cell.packages.skyline-smash-minecraft-skins
      #cell.packages.skyline-ultimate-training-modpack

      #(inputs.nixpkgs.stdenv.mkDerivation {
      #  name = "moz_overlay_shell";
      #  buildInputs = [
      #    # Use latest nightly
      #    pkgs.latest.rustChannels.nightly.rust
      #
      #    # Use specific nightly
      #    #(pkgs.rustChannelOf {date="2018-04-11"; channel="nightly";}).rust
      #
      #    # Use project's rust-toolchain file
      #    #(pkgs.rustChannelOf { rustToolchain = ./rust-toolchain; }).rust
      #  ];
      #})
    ]
    ++ inputs.nixpkgs.lib.flatten cell.packages;
}
