{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # Necessary for QEMU / KVM user session TODO: Conditional based on system config
  # TODO: Use symlink to `/var/lib/libvirt/qemu.conf` instead?
  xdg.configFile."libvirt/qemu.conf".text = ''
    # Adapted from /var/lib/libvirt/qemu.conf
    # Note that AAVMF & OVMF are for aarch64 & x86 respectively
    nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
  '';

  #xdg.configFile.qemu-libvirt = {
  #  target = "${config.xdg.configHome}/libvirt/qemu.conf";
  #  text = ''
  #    # Adapted from /var/lib/libvirt/qemu.conf
  #    # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
  #    nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
  #  '';
  #};

  # TODO: Move distrobox / chroot stuff to a different file (./virt/chroot.nix)
  # TODO: Add Atoms when nixpkg available. https://github.com/AtomsDevs/Atoms
  # TODO: Set flatpak permissions for Atoms: talk to `org.freedesktop.Flatpak`
  home.packages = [
    pkgs.distrobox
  ];

  # TODO: Podman
  # TODO: DistroBox
  # TODO: Bottles
  # TODO: WINE
  # TODO: VMs
  # TODO: Remote desktop protocol & VNC

}
