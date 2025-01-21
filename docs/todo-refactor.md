# Refactoring

## Goals

- `<moduleSystem>/{profiles,modules,lib,overlays,configs}` should contain blocks specific to the module system of type: `<moduleSystem>`
- `<moduleSystem>/profiles/**.nix` should contain **user-agnostic** config.
- `<moduleSystem>/users/**.nix`    should contain **user-specific** config.
- Merge clan repo into this one.
- Merge nix-on-droid repo into this one.
- Use `std` & `hive`.
- Use `omnibus` & POPs.

Top-Level Directory Hierarchy:

```
docs/
lib/
overlays/
packages/
nixos/{configs,lib,modules,profiles,}

```

## Module System Types

- [ ] TODO: colmena?

### Project Architecture

- flake-parts
- flakelight

### Runtime Environments

- nixos
- home-manager
- system-manager
- wrapper-manager
- nix-on-droid

### Artifact Builders

- devShells
- nixvim
- kubenix
- robotnix

## To-Dos


### NixOS

- [ ] Remove dir: `./common` (merge into `./nixos` or `./hm`)

### Home-Manager

TODO: Figure out new apps file structure

- [ ] Remove:  `./hm/profiles/modules`    -> `./hm/profiles/default.nix`
- [ ] Migrate: `./hm/profiles/roles`      -> `./hm/suites/roles`
- [ ] Migrate: `./hm/profiles/gnome/apps` -> `./hm/profiles/apps`
- [ ] Apps get classified by 

`./hm/profiles/apps/app-<name>`
`./hm/profiles/apps/category-<name>.nix` - Import appropriate config based on DE/WM
`./hm/profiles/apps/gnome/<categoryName>`

### Wrapper-Manager

### System-Manager

### DevShells

### Kubenix

- [x] Remove dir: `./kube` (move to project `~/Nix/kubenix-configs`)

### Nixvim

- [ ] Remove dir: `./nixvim` (for now)

### Robotnix

### Nix-On-Droid

### Flake-Parts

#### External Modules

- [ ] `divnix/std`
- [ ] `clan/clan-core`
