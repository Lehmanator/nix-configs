{ inputs, cell, }:
let
  inherit (inputs.std) lib;
  inherit (inputs) std;
in
lib.dev.mkShell {
  name = "hivebus";

  # imports = [ devshellProfiles.rust ];
  # Tool Homepage: https://nix-community.github.io/nixago/
  # This is Standard's devshell integration.
  # It runs the startup hook when entering the shell.
  nixago = [
    #(std.lib.dev.mkNixago std.lib.cfg.just cell.configs.just)
    #(std.lib.dev.mkNixago std.lib.cfg.conform cell.configs.conform)
    ## (inputs.std-ext.presets.nixago.conform cell.configs.conform)
    ## (inputs.std-ext.presets.nixago.treefmt)
    ## (inputs.std-ext.presets.nixago.lefthook)
  ];

  packages = [ inputs.colmena.packages.colmena ];

  commands = [ ];
}
