# NixOS Installer

Create an installation NixOS configuration / environment for installing NixOS from a live USB / live environment.

## Examples / Snippets

```(nix)
outputs = { self, nixos, ... }@inputs: {
  nixosConfigurations.installer = nixos.lib.nixosSystem {
    specialArgs = { inherit inputs; user = "sam"; };
    modules = [ ./profiles/nixos/installer ]; # Note: This will be moved during the next refactor.
  };
};
```

Note: *this snippet was removed from `flake.nix` to declutter.

## To-Dos

- [ ] Refactor to move `lib.lehmanatorSystem` (currently in `./lib/flake/lehmanatorSystem.nix`)
- [ ] Refactor to move `lib.mkSystem` (currently in `flake.nix`).
- [ ] Delete redundant NixOS profile.
