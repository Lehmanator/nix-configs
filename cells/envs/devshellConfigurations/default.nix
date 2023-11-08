{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {

  # --- build dependencies -----------------------
  buildInputs = [
    pkgs.hello

    # keep this line if you use bash
    pkgs.bashInteractive
  ];

  # --- nix-ld -----------------------------------
  # Run unpatched dynamic binaries on NixOS.
  # https://github.com/Mic92/nix-ld
  # Note: Referenced code excluded `pkgs.` before `pkgs` attrs bc used `with import <nixpkgs> {}`
  NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc
    pkgs.openssl
    # ... add other libs here ...
  ];

}
