{ inputs, config, lib, pkgs, user, ... }: {
  imports = [
    #inputs.self.nixosProfiles.qemu-web
  ];
  #virtualisation.qemu = {
  #  guestAgent.enable = true;
  #  diskInterface = "virtio"; # virtio | scsi | ide
  #  networkingOptions = [
  #    "-net nic,netdev=user.0,model=virtio"
  #    "-netdev user,id=user.0,\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS}"
  #  ];
  #  options = [ "-vga std" ];
  #  ovmf = {
  #    enable = true;
  #    packages = with pkgs; [ OVMFFull.fd pkgsCross.aarch64-multiplatform.OVMF.fd ];
  #  };
  #};
  users.extraGroups.qemu-libvirtd.members = [ user ];
  environment.systemPackages = [ pkgs.qemu-utils pkgs.quickemu ];
}
