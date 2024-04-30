# Pops: Pops

Testing pops exports.

## Omnibus

Found in: `inputs.omnibus.pops`

- allData
- configs
- darwinModules
- darwinProfiles
- data
- devshellModules
- devshellProfiles
- example
- flake
- flake-parts
- hive
- homeModules
- homeProfiles
- jupyenv
- load
- microvms
- nixosModules
- nixosProfiles
- overlays
- packages
- scripts
- self
- srvos
- std
- systemManagerProfiles

## Explanations

### `omnibusStd`

Created using:

```(nix)
let
  inputs-all = inputs.nixpkgs.lib.recursiveUpdate
    inputs.omnibus.flake.inputs
    inputs
  ;
  omnibusStd = (inputs.omnibus.pops.std {
    inputs.inputs = inputs-all;
  }).exports.default
in {
  imports = [omnibusStd.flakeModule];
  std.std = omnibusStd.mkStandardStd {
    cellsFrom = ./nix;
    inherit systems;
    inputs = inputs-all;
    nixpkgsConfig = {
      allowUnfree = true;
      overlays = [];
    };
  };
}

```

`inputs.omnibus.pops.std`:

1. Accepts same args as `inputs.haumea.lib.load` function.
2. Uses base loader from `omnibus`:

   ```(nix)
   { src = inputs.omnibus+/units/std;
     loader = [matchers.nix loaders.scoped];
     inputs.inputs = {inherit std;};
   }
   ```

3. Extends base loader using `addLoadExtender`:

   ```(nix)
   baseLoader.addLoadExtender { load = args; };
   ```

4. Extended loader exports attrs `flakeModule` & `mkStandardStd` under `defaults`

`omnibusStd.flakeModule` & `omnibusStd.mkStandardStd`

1. Extends `flakeModule` from `std` with new option `std.std`.
2. Call `omnibusStd.mkStandardStd` to instantiate `std` on attrset used in base `std`:

   - option: `std.grow` (when using `std.flakeModule`)
   - lib: `std.grow` or `std.growOn` (when using `std` without `flake-parts`)

3. Set `std.std` to the resulting instantiated `std`.
4. Sets `std.grow` option of original `std.flakeModule` w/ some of the arg attrs.
5. Passes the rest of the arg attrs to `std.growOn (super.mkContent args)`
6. Provides output attrs:

   - `omnibusStd.blockTypes` (provides `blockTypes` from `omnibus`)
   - `omnibusStd.defaultCellsFrom` (specifies default `cells` for `mkDefaultStd`)
   - `omnibusStd.flakeModule` (outputs module for `flake-parts`)
   - `omnibusStd.mkBlocks`
   - `omnibusStd.mkContent`
   - `omnibusStd.mkCommand`
   - `omnibusStd.mkDefaultStd` (calls `mkStandardStd` w/ defaults)
   - `omnibusStd.mkStandardStd` (instantiates `std`)
   - `omnibusStd.run`

`omnibusStd.mkBlocks.pops`

Takes an attrset where each:

- attr name is the name of a `pop` in `units/std/mkBlocks`
- attr value is the argument attrset expected by `haumea.lib.load`

and returns the `pop` for that attr name.

Path: `"${inputs.omnibus}+/units/std/mkBlocks/pops.nix"`

1. Set `load.inputs = { inputs = inputs-orig + inputs-cell; cell=cell-arg; }`
2. Set `outputs` attrset by mapping `load.inputs` attrsets to their `pops`.
   (using lib: `inputs.omnibus.lib.omnibus.mapLoadToPops`)
3. Set `base` attrset by mapping `mkBlocks.pops` arg attrset to:

   - `outputs.${attrName}.addLoadExtender { load = attrValue; }`
     (when `outputs.${attrName}` exists in `pop` mapped by last step.)
   - `{exports.default=haumea.loaders.scoped commonArgs (v.src+".nix");}`
     (when super class has attr: `attrName`)
   - `attrValue` (when neither above condition met)

4. Defines helper function `mapLoadToPopsHelper` that takes an attrset & returns:

   - `{ load = base.pops.exports.default.${firstKey}; }` (when exists)
   - `{ load = { }; }` (otherwise)

5. Recursively maps attrs in `base` with lib: `mapLoadToPops` that returns:

   - `base.${attrVal}.addLoadExtender (mapLoadToPopsHelper base.${attrName} base.${attrVal})`
     (when `base.${attrVal}.addLoadExtender` not already defined.)
   - `base.${attrVal}`
     (when `base.${attrVal}.addLoadExtender` already defined.)

6. Returns either:

   - Merged attrset of last step with `base.pops.exports.default`
     (when `base.pops.exports.default` is a non-empty attrset)
   - `base`
     (when `base.pops` is not defined or `base.pops.exports.default` is empty.)

`omnibusStd.mkContent`

1. Merges args with default set of `inputs`, `systems`, & `cellBlocks`

2. This only defines `cellBlocks` for items in `units/std/mkBlocks`.

   - `(data         "configs")`
   - `(containers   "containers" {ci.publish=true;})`
   - `(data         "data")`
   - `(functions    "devshellProfiles")`
   - `(jupyenv      "jupyenv")`
   - `(functions    "lib")`
   - `(functions    "nixosProfiles")`
   - `(functions    "nixosModules")`
   - `(functions    "homeProfiles")`
   - `(functions    "homeModules")`
   - `(nixago       "nixago")`
   - `(installables "packages" {ci.build=true;})`
   - `(functions    "pops")`
   - `(runnables    "scripts")`
   - `(devshells    "shells")`
   - `(runnables    "tasks")`

3. Doesn't define `cellBlocks` for available pops in `inputs.omnibus.pops`:

   - `allData`
   - `darwinModules`
   - `darwinProfiles`
   - `devshellModules`
   - `example`
   - `flake`
   - `flake-parts`
   - `hive`
   - `load`
   - `microvms`
   - `overlays`
   - `self`
   - `srvos`
   - `std`
   - `systemManagerProfiles`

4. Doesn't define `cellBlocks` for available `blockTypes`:

   - `std.blockTypes.anything`
   - `std.blockTypes.arion`
   - `std.blockTypes.files`
   - `std.blockTypes.kubectl`
   - `std.blockTypes.namaka`
   - `std.blockTypes.nixostests`
   - `std.blockTypes.nomad`
   - `std.blockTypes.nvfetcher`
   - `std.blockTypes.pkgs`
   - `std.blockTypes.terra`

   - `hive.blockTypes.colmenaConfigurations`
   - `hive.blockTypes.darwinConfigurations`
   - `hive.blockTypes.diskoConfigurations`
   - `hive.blockTypes.homeConfigurations`
   - `hive.blockTypes.nixosConfigurations`

## To-Do

- [ ] Check out libs in `inputs.omnibus.lib.omnibus`

  - `addLoadToPops`
  - `addLoadToPopsFilterBySrc`
  - `cleanSourceTopDefault`
  - `concatProfiles`
  - `inputsToPaths`
  - `loaderInputs`
  - `mapLoadToPops`
  - `mapPopsExports`
  - `mapPopsExports'`
  - `mkPython3PackagesWithScope`

  - `mkHosts`
  - `mkSuites`
  - `mkHome`
