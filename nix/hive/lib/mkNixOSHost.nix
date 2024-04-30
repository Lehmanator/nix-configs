{ inputs, cell, }:
let
  # Found here: https://github.com/GTrunSec/hivebus/blob/e9314e4f8537d61de4567697994f84203d244f56/nix/hive/cells/hosts/lib.nix
  l = inputs.nixpkgs.lib // builtins;
in
export: system: nixos: extra: home: {
  imports = l.flatten export.imports;
  bee = {
    inherit system home;
    pkgs = import nixos ({
      inherit system;
      overlays = l.flatten export.overlays;
    } // extra);
  };
}
