{ inputs, config, lib, pkgs, ... }:
{
  imports = [ inputs.flake-utils-plus.darwinModules.autoGenFromInputs ];
}
