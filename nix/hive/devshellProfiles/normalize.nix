{ inputs, config, lib, pkgs, ... }: {
  # https://github.com/Lassulus/nix-autobahn
  # https://github.com/thiagokokada/nix-alien
  imports = [ ];
  commands = [{
    name = "ldd";
    help = "Figure out what libraries a binary needs.";
    command = "${pkgs.nix-ld}/bin/ldd";
  }];
  env = [
    {
      name = "NIX_LD_LIBRARY_PATH";
      value = lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.openssl ];
    }
    {
      name = "NIX_LD";
      value = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
    }
  ];
  packages = [
    inputs.nix-alien.packages.${pkgs.system}.nix-alien
    pkgs.stdenv.cc
    pkgs.stdenv.openssl
    pkgs.nix-ld
  ];
}
