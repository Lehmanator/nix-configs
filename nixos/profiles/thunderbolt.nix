{ inputs, lib, ... }:
{
  imports = [(inputs.self + /nixos/profiles/usb.nix)];
  boot.initrd.availableKernelModules = [ "thunderbolt" ];
}
