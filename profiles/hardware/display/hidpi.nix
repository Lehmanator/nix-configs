
{ inputs, ... }:
{
  imports = [inputs.nixos-hardware.nixosModules.common-hidpi];
}
