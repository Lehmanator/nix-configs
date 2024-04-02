# `//hive/nixosModules`

## Modules

- [`debug`](./debug.nix): Provide util options to debug NixOS configs.

### To-Do

- [`host-requests`](./requests.md): Allow `home-manager` users to request changes to the host environment.

## Original Loader

Saved from before refactor to `std` & `omnibus` layout.

```(nix)
{ inputs, cell, }:
let inherit (inputs.haumea.lib) load loaders transformers;
in load {
  src = ./nixosModules;
  loader = loaders.verbatim;
  transformer = transformers.liftDefault;
}
```
