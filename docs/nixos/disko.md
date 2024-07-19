# Disko

## Installation Process

Note: **This has likely changed.** Disko now includes a unified installation command for provisioning disks then running `nixos-install`.

- [ ] TODO: Update this with new, accurate installation info.

Write disk by running command:

```(nix)
nix run .#nixosConfigurations.<host>.config.system.build.diskoNoDeps
```

before running:

```(nix)
  nixos-install --flake .#<host>
```
  

## Examples

Enable `nix run` Disko provisioning.
Adapted from: [nix-community/disko - PR #78](https://github.com/nix-community/disko/pull/78#issuecomment-1407375682)

```(nix)
outputs = { self, nixpkgs, flake-utils, ... }@inputs: let
  inherit (flake-utils.lib) eachDefaultSystem;
in rec {

  nixosConfigurations = {
    # ... NixOS configs ...
  };
  
  # Create a runnable app  for each nixosConfiguration to build its disk image.
  apps = eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (nixpkgs.lib) filterAttrs genAttrs optionalAttrs;
    diskoSystems = filterAttrs (_: cfg: (cfg.pkgs.system == system) && (builtins.hasAttr "diskoNoDeps" cfg.config.system.build) );
    hosts = diskoSystems self.nixosConfigurations;
    hasHosts = ! (hosts == {} || ! (builtins.isAttrs hosts));
  in optionalAttrs hasHosts {
    disko = genAttrs (builtins.attrNames hosts (n: {
      type = "app";
      program = "${self.nixosConfigurations.${n}.config.system.build.diskoNoDeps}";
    }));
  });

  # ... rest of flake outputs ...

};
```

Note: *this snippet originated in `flake.nix`,
  but was commented out for a while and moved here to reduce clutter.*

## To-Dos

### Packages

- [ ] Create `packages.disko-ask` script to query user for preferences for disko.
- [ ] Create `packages.disko-tui` script for a Disko TUI like in: [this gist](https://gist.github.com/Mic92/b5b592c0c33d720cb07a070cb8911588)
- [ ] Implement `nix run` like in: [disko - PR #78](https://github.com/nix-community/disko/pull/78)

### NixOS Configurations

- [ ] Export `diskoConfigurations.<name>` with system-independent Disko configurations.
  - [ ] Adapt `nixosConfigurations` to import `diskoConfigurations.${config.networking.hostName}`
