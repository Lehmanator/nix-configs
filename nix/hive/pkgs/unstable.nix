{ inputs, cell, }:
import inputs.nixos-unstable {
  inherit (inputs.nixpkgs) system;
  config = {
    allowUnfree = true;
    #allowUnsupportedSystem = true;
    android_sdk.accept_license = true;
  };
  overlays = with inputs; [
    # omnibus
    agenix.overlays.default
    arion.overlays.default
    audioNix.overlays.default
    devshell.overlays.default
    fenix.overlays.default
    flake_env.overlays.default
    microvm.overlay
    nil.overlays.coc-nil
    nil.overlays.nil
    nix-filter.overlays.default
    nuenv.overlays.nuenv
    nur.overlay
    ragenix.overlays.default
    snapshotter.overlays.default
    sops-nix.overlays.default
    typst.overlays.default

    # flake.nix
    inputs.nix-vscode-extensions.overlays.default
  ];
}