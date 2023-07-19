{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./host.nix
    ./kvm.nix
    ./libvirt.nix
    ./qemu.nix
    ./qemu-web.nix
    ./guest-windows.nix
  ];

}
