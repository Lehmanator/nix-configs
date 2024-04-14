# `//hive/homeProfiles/nushell`

Nushell profile for `home-manager`.

## To-Do

### Table Printer Wrappers

- [ ] Make alias for cleaner `help commands` output.

  - [ ] Remove `index` table column
  - [ ] Remove `command_type` table column
  - [ ] Colorize items in column `name`
    - [ ] Colorize command name according to `command_Type`
    - [ ] Colorize subcommand to use less contrast than command name.

- [ ] Make alias for cleaner `help aliases` output.

  - [ ] Remove table columns: `index`, `decl_id`, `aliased_decl_id`, (`usage`?)
  - [ ] Remove text `"Alias for"` from `usage` column. (if not removing column)

- [ ] Table printer wrapper for `nix-diff`
- [ ] Table printer wrapper for `manix`
