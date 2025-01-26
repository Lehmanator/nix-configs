{inputs, ...}: {
  imports = [(inputs.self + /nixos/profiles/usb.nix)];
  boot.initrd.availableKernelModules = ["thunderbolt"];
  services.hardware.bolt.enable = true;
}
