# Hive: `lib`

## To-Do

- [ ] Pass extra `nixpkgs` to systems:
      (originally inside `flake.nix` helper wrapper `mkSystem` around `nixos.lib.nixosSystem`)

  Reasoning:

  > Instantiate all instances of nixpkgs in `flake.nix` up-front to avoid
  > creating new nixpkgs instances for every `import nixpkgs` call within submodules/subflakes.
  > Saves time & RAM.

  Source:

  - [`thiscute.world/downgrade-or-upgrade-packages`](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages)
  - [`thiscute.world/nixpkgs/multiple-nixpkgs`](https://nixos-and-flakes.thiscute.world/nixpkgs/multiple-nixpkgs)

  ```(nix)
  pkgs-master = import inputs.nixpkgs-master {
    inherit system;
    config.allowUnfree = true;
  };
  ```

- [ ] Do the above for all `nixpkgs` branches.
      (e.g. `stable`, `unstable`, `master`, `staging`, `staging-next`)
