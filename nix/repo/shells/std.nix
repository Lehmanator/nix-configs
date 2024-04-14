{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs;
  inherit (inputs.std) lib std;
in
  lib.dev.mkShell {
    # `default` is a special target in newer nix versions
    # see: harvesting below
    name = "Standard Default Devshell";
    # make `std` available in the numtide/devshell
    #imports = [ std.devshellProfiles.default ];
    imports = [cell.devshellProfiles.std-base];
  }
