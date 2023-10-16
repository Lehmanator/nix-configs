{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  nixpkgs.overlays = [ inputs.fenix.overlays.default ];
  home.packages = [
    pkgs.fenix.complete.toolchain
    #pkgs.fenix.stable.completeToolchain
    #(pkgs.fenix.stable.withComponents [ "cargo" "clippy" "rust-src" "rustc" "rustfmt" ])
    #pkgs.rust-analyzer-nightly
  ];
}
