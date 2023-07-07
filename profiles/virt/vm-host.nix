{
  self,
  system,
  userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  environment.systemPackages = [
    #pkgs.gnome-boxes
    pkgs.spice-protocol
    pkgs.virt-manager
    pkgs.win-spice
  ];


  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  virtualisation.kvmgt.enable = true;
  virtualisation.libvirtd.enable = true;
  #virtualisation.qemu.guestAgent.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  users.extraGroups = {
    kvm           = { name = "kvm";           members = [ "sam" ]; };
    libvirtd      = { name = "libvirtd";      members = [ "sam" ]; };
    qemu-libvirtd = { name = "qemu-libvirtd"; members = [ "sam" ]; };
  };
}
