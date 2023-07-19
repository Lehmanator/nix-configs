{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  environment.systemPackages = [
    #pkgs.gnome-boxes
    pkgs.spice-protocol
    pkgs.virt-manager
  ];

  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  virtualisation = {
    kvmgt.enable = true;                 # Share Intel integrated graphics with guest.
    libvirtd.enable = true;
    hypervGuest.enable = true;
    #qemu.guestAgent.enable = true;
    spiceUSBRedirection.enable = true;

    #forwardPorts = [
    #  { from = "host"; host.port = 2222; guest.port = 22; }
    #  { from = "host"; host.port = 2223; guest.port = 22; }
    #  { from = "host"; host.port = 2224; guest.port = 22; }
    #];
  };

  users.extraGroups = {
    kvm           = { name = "kvm";           members = [ user ]; };
    libvirtd      = { name = "libvirtd";      members = [ user ]; };
    qemu-libvirtd = { name = "qemu-libvirtd"; members = [ user ]; };
  };
}
