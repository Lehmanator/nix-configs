{ inputs, config, lib, pkgs, ... }:
let
  inherit (inputs.haumea.lib) load;
in
{
  imports = [];
  environment.shells = [pkgs.nushellFull];
}
