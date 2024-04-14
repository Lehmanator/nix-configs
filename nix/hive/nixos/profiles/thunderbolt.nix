{ lib, ... }:
{
  boot.initrd.availableKernelModules = [ "thunderbolt" ];
}
