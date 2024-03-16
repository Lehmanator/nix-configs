# Hive Cell

Cell contains everything related to permanent Nix environments.
Geared mostly towards NixOS & home-manager.

See more:

- [`./diskoConfigurations`](./diskoConfigurations/Readme.md)
- [`./homeConfigurations`](./homeConfigurations/Readme.md)
  <!--- [`./homeModules`](./homeModules/Readme.md)-->
  <!--- [`./homeProfiles`](./homeProfiles/Readme.md)-->
  <!--- [`./homeSuites`](./homeSuites/Readme.md)-->
- [`./lib`](./lib/Readme.md)
<!--- [`./nixosConfigurations`](./nixosConfigurations/Readme.md)-->
- [`./nixosModules`](./nixosModules/Readme.md)
- [`./nixosProfiles`](./nixosProfiles/Readme.md)
- [`./nixosSuites`](./nixosSuites/Readme.md)
- [`./packages`](./packages/Readme.md)
- [`./shells`](./shells/Readme.md)

## Omnibus

Omnibus is a library to apply Pure Object Prototypes (POPs) to config components.
This library can be used standalone or complement `std`/`hive`.

I use `omnibus` with `std` to create a custom `flakeModule` for `flake-parts`.
This extends the original `std` `flakeModule` to add POPs functionality.

### `mkBlocks` `POPs`

`mkBlocks.pops` is a library function to map an attrset to their pre-defined POPs.

These are the POPs that `mkBlocks.pops` creates.

- `configs`
- `data`
- `devshellProfiles`
- `homeModules`
- `homeProfiles`
- `jupyenv`
- `nixosModules`
- `nixosProfiles`
- `packages`
- `pops`
- `scripts`
- `shells`
- `tasks`

### `omnibus` `POPs`

These are the POPs defined & provided by `omnibus`.

- `allData` (_missing in_ `mkBlocks`)
- `configs`
- `darwinModules` (_missing in_ `mkBlocks`)
- `darwinProfiles` (_missing in_ `mkBlocks`)
- `darwinProfilesOmnibus` (_missing in_ `mkBlocks`)
- `data`
- `devshellModules` (_missing in_ `mkBlocks`)
- `devshellProfiles`
- `example` (_missing in_ `mkBlocks`)
- `flake` (_missing in_ `mkBlocks`)
- `flake-parts` (_missing in_ `mkBlocks`)
- `hive` (_missing in_ `mkBlocks`)
- `homeModules`
- `homeProfiles`
- `homeProfilesOmnibus` (_missing in_ `mkBlocks`)
- `jupyenv`
- `load` (_missing in_ `mkBlocks`)
- `microvms` (_missing in_ `mkBlocks`)
- `nixosModules`
- `nixosProfiles`
- `nixosProfilesOmnibus` (_missing in_ `mkBlocks`)
- `overlays` (_missing in_ `mkBlocks`)
- `packages`
- `scripts`
- `self` (_missing in_ `mkBlocks`)
- `srvos` (_missing in_ `mkBlocks`)
- `std` (_missing in_ `mkBlocks`)
- `systemManagerProfiles` (_missing in_ `mkBlocks`)

### `blockTypes` without `POPs`

These are `blockTypes` for `std` from `divnix/std` or `divnix/hive`
that don't have POPs defined by `omnibus`.

### Custom `POPs`

These are custom types to define POPs for.

May want to define:

- `blockTypes.<name>`
- `pops.<name>`

### Loading

Functions to load other configs.

Loading via `POPs` uses `omnibus.pops.load`,
and uses syntax matching `haumea.lib.load`.

Existing POPs:

```(nix)
<popName> = inputs.omnibus.pops.<popName>.addLoadExtender {
  src = ./<popName>;
  inputs = {
    # attrs to pass
  };
};
```

Custom POPs:

```(nix)
<customPop> = inputs.omnibus.pops.load {
  load = {
    src = ./<customPop>;
    loader = <loaderName>;
    matcher = <matcherName>; # ??
    transformer = <transformerName>;
    inputs = {
      inherit inputs cell;
      # attrs to pass
    };
  };
};
```

Reuse pops from other cells/cellBlocks:

```(nix)
<extendedPop> = cell.pops.<popName>.addLoadExtender {
  src = ./<extendedPop>;
  inputs = {
     inherit inputs cell;
     # attrs to pass.
  };
};
```

#### Loaders

Haumea:

- `haumea.lib.loaders.callPackage`
- `haumea.lib.loaders.default`
- `haumea.lib.loaders.scoped`
- `haumea.lib.loaders.verbatim`

Omnibus:

- [`loaders.removeTopDefault`](https://github.com/GTrunSec/omnibus/blob/main/src/lib/haumea/removeTopDefault.nix)

Custom:

#### Matchers

- `haumea.lib.matchers.always`
- `haumea.lib.matchers.extension`
- `haumea.lib.matchers.json`
- `haumea.lib.matchers.nix`
- `haumea.lib.matchers.regex`
- `haumea.lib.matchers.toml`

Custom:

- `excludeNested` (beyond threshold)
- `excludeDefault`

#### Transformers

- `haumea.lib.transformers.hoistAttrs`
- `haumea.lib.transformers.hoistLists`
- `haumea.lib.transformers.liftDefault`
- `haumea.lib.transformers.prependUnderscore`

Custom:

- `prependCategory` - Prefix name like: `<category>-<name>`
- `nestingSepReplace` - Rename nested directories w/ separator.

- `wrapProfileModule` - Wrap `{nixos,hm,etc}Profile` with `mkEnable` option, & rename to `nixosModules.profile-<profileName>`
- `wrapSuiteModule` - Wrap `{nixos,hm,etc}Suite` with `mkEnable` option, & rename to `nixosModules.suite-<suiteName>`

- Scoped packages

## Help

- [ ] Figure out best way to load / create `homeConfigurations`
- [ ] Figure out best way to load / create `nixosConfigurations`

- [ ] Figure out how to use `mkSuites`

See: [omnibus: `units/nixos/nixosProfiles`](https://github.com/GTrunSec/omnibus/blob/main/units/nixos/nixosProfiles/cloud.nix#L43)

```(nix)
mkSuites {
  default = [
    { keywords = ["srvos" "server" "presets" "init"];
      knowledges = ["https://github.com/nix-community/srvos"];
      profiles = [
        nix openssh
        srvosCustom.common.default
        srvosCustom.common.sudo
        srvosCustom.common.upgrade-diff
        srvosCustom.mixins.nix-experimental
        srvosCustom.server.default
        ({pkgs, lib, ...}: {boot.kernelPackages=lib.mkDefault pkgs.linuxPackages_latest;})
      ];
    }
  ];
};
```
