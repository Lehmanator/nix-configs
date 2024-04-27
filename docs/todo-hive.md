# To-Dos: Hive / std

- [X] Add inputs
- [X] Create directory `<REPO_ROOT>/cells`
- [X] Spread attrs from inputs `std` & `hive` in `outputs = { ... }@inputs` line
- [X] Create flake output attrset passed as 1st arg to `std.growOn` to describe project directory structure
  - [X] Add attr `cellsFrom = ./cells;`
  - [X] Add attr `cellBlocks = [ ... ];`
- [X] Create flake output attrset passed as 2nd arg to `std.growOn` to describe desired output structure.
- [X] Recursively merge `std.growOn` outputs with outputs of existing config

- [ ] Convert **NixOS**        profiles to `paisano` / `std` / `hive` structure using args: `{ self, inputs, cell }`
- [ ] Convert **home-manager** profiles to `paisano` / `std` / `hive` structure using args: `{ self, inputs, cell }`

- [ ] Create generic **home-manager** profiles for various employee roles
  - [ ] common
  - [ ] accounting
  - [ ] guest
  - [ ] manager
  - [ ] shipping
  - [ ] sysadmin
  - [ ] webdev
