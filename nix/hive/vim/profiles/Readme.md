# `//hive/vimProfiles`

Reusable configuration profiles for [Nixvim](https://github.com/nix-community/nixvim).

## Goals

- Create generic `nixvim` profiles to be imported in various environments.
  e.g. NixOS, home-manager, devshells, etc.
- Allow `nixvim` profiles to depend on environment config module attrs.
  e.g. `config`, `osConfig`, `nixosConfig`, etc.

- Create standalone package wrapping `neovim` with its profile's configuration.
- Allow running `nixvim` configurations from the `nix run` CLI.

## Outputs

Each config type should have:

- accessible inside cell blocks: `modules`, `suites`, `profiles`
- flake outputs: `modules`

Nix CLI only displays `nixosModules` in the `nix flake show` output.
We want to import profiles with little effort in configs, suites, and other profiles,
so we make suites & profiles available inside the cell block.

We want to allow safely importing modules in external flakes,
without the import altering the config of the importer,
so we only export modules,
which must be explicitly enabled to alter the importer's config.

### Cell Blocks

- `vimModules.<name>`
- `vimProfiles.<name>`
- `vimSuites.<name>`

### Flake Outputs

- `homeModules.nixvim-profile-<name>`
- `nixosModules.nixvim-profile-<name>`
- `packages.${system}.nixvim-wrapped-profile-<name>`

### Generalization

This concept is generic to program-specific config profiles,
so we will do similarly for other programs.

The only programs that make sense to split into profiles are ones with complex configurations,
which means only a few types of programs will get separate profiles.

e.g. web browsers, text editors, shells, etc.

It also might be possible to genericize some config profiles into ones that apply to their entire category.

e.g. Share keymaps between `nixvim` & `vscodium`
e.g. Share web extension settings between `firefox` & `chromium`

## To-Do

Create generic export libs to transform config profiles (`<type>Profiles.<name>`) into:

- [ ] Module of same config type (`<type>Modules.profile-<name>`)
- [ ] Home-Manager profiles (`homeProfiles.<type>-<name>`)
- [ ] Profiles of environment types (`<envType>Profiles.<type>-<name>`)
  - [ ] darwin, home-manager, nixos, nix-on-droid, system-manager, wsl

Create `Nixvim` specific exporters:

- [ ] Instantiate generic libs with target environment config type name.
- [ ] Add exporters to POP with `cell.pops.vimProfiles.addExporters`
- [ ] Add collectors in `std.pick` with `homeModules=[["hive" "vimProfiles"]`

Config generalization:

- [ ] Find list of programs of same category that can be configured with Nix.
- [ ] Find areas where same config can apply to multiple programs.
- [ ] Map config options for one program into options for the other(s).
- [ ] Create wrapper lib to translate between these configs.
- [ ] Create exporters for config types that translate into other program's options.
- [ ] Create generic object cell blocks & POPs for generic program categories.
  - [ ] `editorProfiles`, `editorModules`, `editorSuites`
  - [ ] `browserProfiles`, `browserModules`, `browserSuites`
  - [ ] `replProfiles`, `replModules`, `replSuites`
