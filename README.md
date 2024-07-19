# Nix / NixOS Configs

❄️  Welcome! ❄️

*What do we have here?*

- Work-in-progress set of [NixOS](https://nixos.org) configs.
- Catalog of bad decisions I have made throughout my Nix journey (refactor in progress).
- Collection of personal [NixOS](https://nixos.org) & [home-manager](https://github.com/nix-community/home-manager) profiles (each with varying degrees of maintainence).
- My personal NixOS configurations.
- Living document of my learning process with Nix & the many tragedies I have overcome.

If you are an end-user, you may find some stuff here that you find useful.
You'll have to dig through the rest to find it.

As of now, this repo is only intended for personal use.
Exported outputs are not intended to be consumed by other flakes.
This may change eventually.

More documentation & information can be found in: [`./docs`](./docs)

## History & Backstory

I have been going back-and-forth between using several Nix libs to organize my stuff.
Still haven't settled on which I'd ultimately prefer to use,
so there exists a lot of unused boilerplate specific to each framework I have messed around with.

These include:

- [`divnix/std`](https://github.com/divnix/std) - Software development lifecycle framework for Nix.
- [`divnix/hive`](https://github.com/divnix/hive) - Like `std`, but for NixOS-related flake outputs.
- [`divnix/flops`](https://github.com/divnix/flops) - POP libs for flake outputs.
- [`tao3k/omnibus`](https://github.com/tao3k/omnibus) - POP definitions for common flake outputs.
- [`numtide/flake-parts`](https://github.com/numtide/flake-parts) - Module system for flake outputs.
- [`nix-community/haumea`](https://github.com/nix-community/haumea) - Loaders for Nix configurations.

Previously including:

- [`snowfallorg/lib`](https://github.com/snowfallorg/lib)

## Outputs

- `nixosConfigurations`
- `packages`
- `devShells`

## Planning & To-Dos

### Near-future

- [x] Start adding secrets encrypted with `sops-nix`.

- [ ] Disko-ify my existing machines.
  - [ ] `fw`
  - [ ] `wyse`
  - [ ] `fajita` (possible to do with `mobile-nixos`? `systemd-repart`?)

- [ ] Secure Boot on everything via [`lanzaboote`](https://github.com/nix-community/lanzaboote).
- [ ] Ephemeral configs via [`impermanence`](https://github.com/nix-community/impermanence).

- [ ] Custom NixOS installer image with:
  - Nix `experimental-features` enabled by default: `nix-command`, `flakes`, `recursive-nix`, `ca-derivations`.
  - Ready for full-disk-encryption & secure boot with resume from hibernate out of the box.
  - Disko package pre-loaded.
  - [ ] `packages.${system}.bootstrap-disko-select` to present TUI to select from `diskoConfigurations` to pass to installer.
  - [ ] `packages.${system}.bootstrap-new-system` to build new system config from existing `nixosConfigurations` and runtime data.
  - [ ] `packages.${system}.bootstrap-secrets` to transform existing `nixosConfigurations` to use combination of newly-generated and inherited secret values.

### Configuration Types

Other types of Nix-based configurations to define.

#### System Types

- [ ] `nixOnDroidConfigurations` - [`nix-on-droid`](https://github.com/nix-community/nix-on-droid) configurations for custom Nix-based environment in Android / Termux.

#### System Images

- [ ] `openwrtConfigurations` - OpenWRT custom router OS configurations (See: [`./docs/configs/openwrt.md`](./docs/configs/openwrt.md))
- [ ] `robotnixConfigurations` - [`robotnix`](https://github.com/nix-community/robotnix) configurations for custom Android OS images.

#### Hardware Configurations

- [ ] `diskoConfigurations` - [`disko`](https://github.com/nix-community/disko) configurations for hard disk layouts.

#### Editor Configurations

- [ ] `nixvimConfigurations` - [`nixvim`](https://github.com/nix-community/nixvim) configurations for Neovim configs.
  - Modularized to exist as:
    - Standalone Neovim wrapper
    - NixOS profile
    - home-manager profile.

- [ ] `codiumConfigurations` akin to `nixvimConfigurations, but for VSCodium.`
- [ ] `helixConfigurations` akin to `nixvimConfigurations, but for Helix.`
- [ ] `editorConfigurations` akin to `nixvimConfigurations`, but abstracted to many editors.
  - Possible conversion util / lib.

### Infrastructure

- [ ] Kubernetes cluster from various machines.
- [ ] Migration of my Kubernetes manifests & Helm charts to Nix
- [ ] Netboot server & config images
- [ ] Binary cache & remote builders
- [ ] NUR repo & overlays
- [ ] Terranix configs

### Modules

- [ ] Flakify [`mobile-nixos/mobile-nixos`](https://github.com/mobile-nixos/mobile-nixos)
- [ ] Genericize configuration options between Chromium & Firefox.
- [ ] LDAP directory trees as Nix config.

### Packages

- [ ] GNOME apps missing from `nixpkgs`

### Ideas n stuff

- `homeConfigurations` as a composition of `devShells`


