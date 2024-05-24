# `//hive/pops`

This cellBlock provides POP definitions.
cellBlock should contain definitions for pops related to:

- NixOS
- home-manager
- nix-darwin
- nixos-wsl
- system-manager

Other pops should be placed in their relevant cellBlocks.

## File Structure

`./default.nix`:

- Responsible for passing POP definitions to `std`
  e.g. call `inputs.omnibusStd.mkBlocks.pops`

```(txt)
nix/
  - pops/
    - inputsExtenders
    - inputsTransformers
    - lib/
      - default.nix    (cell.pops.lib.exports.default)
      - mkBlocks.nix   - Convert POPs to `std` cell blocks.
      - mkCellPOP.nix  - Convert POP to be used inside different cell w/ same structure
    - pop/
      - blocks.nix
      - default.nix
      - pop.nix
      - std.nix


```

## To-Do

### To-Do: `//hive/pops`

See comments in [`./default.nix`](./default.nix) for more.

- [ ] Migrate all base pops to `//pops/pops` cell block.
- [ ] Extend base pops in `//pops` cell with `hive` related behaviors.

### To-Do: `//pops/pops`

Cell `//pops` is for defining POPs that can be reused/extended by other cells.

POPs here should be able to be imported before `std`?

- [ ] Define base POPs in `<projRoot>/pops/`, so they can be used before `std` is instantiated?
  - [ ] POPs in `//pops/pops` can just import these and extend with `std` cell information.
