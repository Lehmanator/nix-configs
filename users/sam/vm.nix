{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # Necessary for QEMU / KVM user session
  # TODO: Conditional based on system config
  # TODO: Use symlink to `/var/lib/libvirt/qemu.conf` instead?
  xdg.configFile.qemu-libvirt = {
    target = "${config.xdg.configHome}/libvirt/qemu.conf";
    text = ''
      # Adapted from /var/lib/libvirt/qemu.conf
      # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
      nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
    '';
  };

}
