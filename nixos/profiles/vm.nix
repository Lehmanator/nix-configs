{inputs, ...}: {
  imports = [
    (inputs.self + /nixos/profiles/vm-host.nix)
    (inputs.self + /nixos/profiles/libvirt.nix)
    (inputs.self + /nixos/profiles/kvm.nix)
    (inputs.self + /nixos/profiles/qemu.nix)
    (inputs.self + /nixos/profiles/qemu-web.nix)
    # (inputs.self + /nixos/profiles/vm-guest-windows.nix)
  ];
}
