{
  inputs,
  cell,
  pkgs,
  lib,
  config,
  ...
}: {
  #imports = [inputs'.devshell.flakeModule];
  commands = [];
  #devshell = {};
  env = [];
  packages = [
    pkgs.nix-your-shell
    #inputs.fenix.packages.complete.toolchain
    #pkgs.fenix.stable.completeToolchain
    #(pkgs.fenix.stable.withComponents [ "cargo" "clippy" "rust-src" "rustc" "rustfmt" ])
    #pkgs.rust-analyzer-nightly

  ];
}
