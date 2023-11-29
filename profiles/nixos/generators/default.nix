{ inputs, config, lib, pkgs, ... }:
{
  imports = [ inputs.nixos-generators.nixosModules.all-formats ];
}
