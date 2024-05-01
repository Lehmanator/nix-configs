# //hive/hosts

Host configurations.

Host definitions contain information required to build configurations for:

- host system configs: `nixosConfigurations`, `darwinConfigurations`, `wslConfigurations`, `termuxConfigurations`, or `systemManagerConfigurations`
- `home-manager` environment of main user.
- `colmenaHive` config from collections of hosts.

## Interface

## Under-the-Hood

`mkHosts`

`pops.hive.setHosts`

## Hosts

### fw

## To-Do

- [ ] Figure out interface schema of `mkHost`
- [ ] Create attrsets / dirs for each machine.
- [ ] Configure POPs to export proper config type.
- [ ] Configure `cellBlocks` to use `nixosConfigurations`, etc.
- [ ] Configure `colmena`
- [ ] Create a `blockTypes.pkgs` that imports overlays from each flake input.
- [ ] Create a `lib` to collect relevant flake outputs from each flake input.
  - [ ] homeModules / homeManagerModules / hmModules
  - [ ] k8sManifests
  - [ ] lib
  - [ ] nixosModules / nixosModule
  - [ ] overlays / overlay
  - [ ] packages

Upstream `omnibus` changes:

- [ ] Export `diskoConfigurations.<hostname>` using `nixosConfigurations.<hostname>.config.disko` options
- [ ] Enable support for alternate system types:

  - [ ] `nixOnDroidConfigurations`
  - [ ] `systemManagerConfigurations`
  - [ ] `wslConfigurations`
