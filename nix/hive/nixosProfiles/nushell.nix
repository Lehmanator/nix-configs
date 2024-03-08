{ inputs, config, lib, pkgs, ... }:
{
  imports = [];
  environment.shells = [pkgs.nushellFull];
}
