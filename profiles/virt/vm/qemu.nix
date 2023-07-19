{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    ./qemu-web.nix
  ];

  virtualisation.qemu = {
    guestAgent.enable = true;
    diskInterface = "virtio";    # virtio | scsi | ide
    #networkingOptions = [
    #  "-net nic,netdev=user.0,model=virtio"
    #  "-netdev user,id=user.0,\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS}"
    #];
    #options = [
    #  "-vga std"
    #];
    ovmf = {
      enable = true;
      packages = [ pkgs.OVMFFull.fd pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd ];
    };
  };
  environment.systemPackages = [ pkgs.qemu-utils ];
  #users.extraGroups.qemu-libvirtd = lib.mkIf config.virtualisation.libvirtd.enable { name = "qemu-libvirtd"; members = [user]; };

}
