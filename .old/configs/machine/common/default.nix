{
  self,
  inputs,
  hosts, networks, repo,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.hardware
  ];


}
