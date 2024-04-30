# Hive: `devShells`

## Shells

### `nixos`

Main shell for using with NixOS / `home-manager`.

## To-Do

- [ ] Create `nix-direnv` file `.envrc` for each `cell` in `std` to activate default `devShell` for `cell`.
  - e.g. Entering `<repo>/nix/hive` enters the `devShell` from `hive`, but entering `<repo>` enters a diff shell.

Old, but saving here.

From `devshells.nix`:

```(nix)
{ inputs, cell, }:
let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.haumea.lib) load loaders matchers transformers;
  #l.mapAttrs (_: inputs.std.lib.dev.mkShell) (load {
in
{ }
#load {
#  src = ./shells;
#  loader = loaders.verbatim;
#  #loader = i: path: inputs.std.lib.dev.mkShell (import path { inherit inputs cell; });
#  transformer = transformers.liftDefault;
#  inputs = { inherit inputs cell; };
#}
```
