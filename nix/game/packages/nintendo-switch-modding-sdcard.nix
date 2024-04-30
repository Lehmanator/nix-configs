{
  inputs,
  cell,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
  pkgs = inputs.nixpkgs;
in
  pkgs.stdenv.mkDerivation {
    pname = "nintendo-switch-sdcard";
    meta = {maintainers = [lib.maintainers.lehmanator];};
  }

