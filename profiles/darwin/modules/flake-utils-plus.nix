{ inputs, pkgs, ... }:
{
  imports = [ inputs.flake-utils-plus.darwinModules.autoGenFromInputs ];
}
