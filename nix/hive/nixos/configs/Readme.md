# `//hive/nixosConfigurations`

The `cellBlock` that provides my NixOS configurations.

## Machines

Format: `nixosConfigurations.<system>-<variant>-<environment>`

Where:

- `<machine>` is the name of some machine's hardware.
- `<variant>` is the name of some variation to extend the original `nixosConfigurations.<machine>`
- `<environment>` is the name of some runtime enviroment type to transform the original `nixosConfigurations.<machine>-<variant>`.

Format: `nixosConfigurations.<system>`
Format: `nixosConfigurations.<system>-<variant>`

- `fw`
- `wyse`
- `fajita`
- `galaxy-tab-a8`

### Machine Variants

Each machine should also have a series of variants that also provide `nixosConfigurations`.
Variants should configure behavior under option: `specialisations.<variant>`.

Usage:

- `sudo nixos-rebuild --specialisation <variant>`
- `sudo nixos-rebuild -c <variant>`
- `sudo /run/current-system/specialisation/<variant>/bin/switch-to-configuration test`

- [ ] TODO: Use NixOS options in `specialisations` to configure this behavior?
  - [ ] TODO: Determine what options (if any) needs extra item in `nixosConfigurations`
  - [x] TODO: Nix/NixOS lib to remove imported module/config/options? (`disabledModules=[]`)

#### Default

The default configuration for the system.

Formats:

Name: `nixosConfigurations.<machine>-default`
Name: `nixosConfigurations.<machine>-default-<environment>`
Name: `specialisation.default`

#### Installer

Installation live environment.
Name: `nixosConfigurations.<system>-installer`
Name: `specialisation.installer`

#### Minimal

Removes everything but what is necessary to use hardware. Helps testing.

Name: `nixosConfigurations.<machine>-minimal`
Name: `specialisation.minimal`

#### Removed home-manager

Removes home-manager to test config when `homeConfigurations.<machine>` broken.

Name: `specialisation.homemanager-config-<homeConfiguration>`
Name: `specialisation.homemanager-config-none`

#### User

Removes default user from system & sets up generic user.
Name: `specialisation.user-none`

#### Secrets

Use secrets from other `nixosConfigurations` on different machine
or remove them altogether.

Removes secrets from `sops-nix` & `agenix`, and sets paths to defaults.
Intention is to provide configs that don't depend on `sops` / `age` secrets,
letting me (or other users) create their own at runtime.

Name: `nixosConfigurations.<machine>-no-secrets`
Name: `specialisation.secrets-<nixosConfiguration>`
Name: `specialisation.secrets-none`

- Keep `sops` options
- Remove/disable options: `system.activationScripts` for `sops-nix`/`agenix`
- Create script to write secret files with empty data.
- Create script to write secret files with newly generated data.
- Create script to reload `systemd` units after writing new secrets.

#### Modules

Disable external modules imported in the `nixosConfigurations.<machine>`

Name: `specialisation.modules-<nixosConfiguration>`
Name: `specialisation.modules-none`

#### Disko

Use `diskoConfigurations.<machine>` on a different machine
or disable `disko` altogether.

Name: `specialisation.disko-<nixosConfiguration>`
Name: `specialisation.disko-none`

#### Filesystem

Use filesystems defined in other `nixosConfigurations`
or use nothing (or minimal fs options).

Name: `specialisation.filesystems-<nixosConfiguration>`
Name: `specialisation.filesystems-none`

#### Disable Impermanence

Disables `impermanence` options
, mounting the permanent files safely to their expected locations.

Name: `specialisation.permanent`
Name: `specialisation.permanent-all`
Name: `specialisation.permanent-home`
Name: `specialisation.permanent-root`

- Disable impermanence module / remove options?
- Use impermanence option values to mount files/dirs to their expected locations.

### Machine Environments

Each machine & variant combo should also have a series of runtime environments
with configuration tailored to run a given config inside a specific class of environment.

Environments should use options from `nixos-generators` whenever possible,
and only fallback to creating a new item in `nixosConfigurations` when necessary.

Environments:

- `container`
- `installer`
- `netboot`
- `vm`

- [ ] TODO: Determine what behavior (if any) cannot use `nixos-generators`

## Modules

Default imports (for all `nixosConfigurations`):

- `disko`
- `lanzaboote`
- `agenix`
- `home-manager`
- `nur`
- `sops-nix`

## Original Layouts

Config & results from before my big refactor.
Saving in case I need to see results from my configs before
the introduction of `std` & `omnibus`.

### `nixosConfigurations`

```(nix)

nix-repl> nixosConfigurations
{ fajita = { ... }; fajita-minimal = { ... }; fw = { ... }; wyse = { ... }; }

nix-repl> nixosConfigurations.fw
{ _module = { ... }; _type = "configuration"; class = "nixos"; config = { ... }; extendModules = «lambda @ /nix/store/2p9qcybzmx1rfayjw866rz8xljbw45g9-source/nixos/lib/eval-config.nix:114:21»; extraArgs = { ... }; lib = { ... }; options = { ... }; override = { ... }; overrideDerivation = «lambda @ /nix/store/2p9qcybzmx1rfayjw866rz8xljbw45g9-source/lib/customisation.nix:111:32»; pkgs = { ... }; type = { ... }; }
```

### `homeConfigurations`

```(nix)
nix-repl> homeConfigurations
{ sam = { ... }; }

nix-repl> homeConfigurations.sam

{ activation-script = «derivation»; config = { ... }; extendModules = «lambda @ /nix/store/z60vipibaff1mz8n5cjnh22p33lldba8-source/modules/default.nix:59:23»; newsDisplay = "show"; newsEntries = [ ... ]; options = { ... }; pkgs = { ... }; }
```
