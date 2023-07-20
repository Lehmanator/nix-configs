{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    ./qemu-web.nix
  ];

  #virtualisation.qemu.guestAgent.enable = true;
  #virtualisation.qemu.diskInterface = "virtio";    # virtio | scsi | ide
  #virtualisation.qemu.ovmf = {
  #  enable = true;
  #  packages = [ pkgs.OVMFFull.fd pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd ];
  #};
  #virtualisation.qemu.networkingOptions = [
  #  "-net nic,netdev=user.0,model=virtio"
  #  "-netdev user,id=user.0,\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS}"
  #];
  #virtualisation.qemu.options = [
  #  "-vga std"
  #];

  #users.extraGroups.qemu-libvirtd = lib.mkIf config.virtualisation.libvirtd.enable { name = "qemu-libvirtd"; members = [user]; };

  environment.systemPackages = [
    pkgs.qemu-utils
    pkgs.quickemu
  ];

}
