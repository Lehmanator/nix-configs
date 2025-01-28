{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
#let
#  uuid = "6a1eb126-267f-11ee-a91c-075c79e9269a";
#in
{
  # https://nixos.wiki/wiki/NixOps/Virtualization
  imports = [
    # ./integration.nix
    # ./hyperv.nix
    # ./xen.nix
  ];

  # --- Hypervisors ---
  # Hyper-V, Xen, KVM
  # TODO: Configure Xen
  # virtualisation.hypervGuest = {
  #   enable = true;
  #   videoMode = "1152x864";
  # };

  # --- Guest Integration ---
  environment.systemPackages = [
    #pkgs.gnome-boxes
    #pkgs.guestfs-tools
    #pkgs.libguestfs
    #pkgs.libguestfs-appliance
    pkgs.spice
    pkgs.spice-protocol
    pkgs.spice-gtk
    pkgs.python3Packages.guestfs
  ];

  # Guest-only?
  services.spice-vdagentd.enable = true;

  # Share files between host & guest via WebDAV
  services.spice-webdavd.enable = true;

  # USB device access in guest VM
  virtualisation.spiceUSBRedirection.enable = true;

  #virtualisation.sharedDirectories = {   # nixos-rebuild says this option doesnt exist
  #  windows   = { source = "/mnt/share/windows";   target = "C:/host-share/windows";   };
  #  windows10 = { source = "/mnt/share/windows10"; target = "C:/host-share/windows10"; };
  #  windows11 = { source = "/mnt/share/windows11"; target = "C:/host-share/windows11"; };
  #  general   = { source = "/mnt/share/general";   target = "C:/host-share/general";   };
  #};

  #virtualisation.forwardPorts = [
  #  { from = "host"; host.port = 2222; guest.port = 22; }
  #  { from = "host"; host.port = 2223; guest.port = 22; }
  #  { from = "host"; host.port = 2224; guest.port = 22; }
  #];

  #virtualisation.mountHostNixStore = true;
  #virtualisation.useNixStoreImage = true;
  #virtualisation.additionalPaths = [];

  # --- Host Config ---
  #virtualisation.cores = 1;
  #virtualisation.directBoot.enable = !config.virtualisation.useBootLoader;
  #virtualisation.directBoot.initrd = "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}";
  #virtualisation.diskImage = "./${config.system.name}.qcow2";
  #virtualisation.diskSize = 1024;
  #virtualisation.emptyDiskImages = [];  # Additional disk images to provide to VM. Value is list of disk sizes (MB). Disks writeable by VM
  #virtualisation.fileSystems = {<name>={..};};
  #virtualisation.host.pkgs = (import pkgs.path { system = "aarch64-linux"; });  # Allow running x86 NixOS VMs on ARM64
  #virtualisation.interfaces = {<name>={..};};
  #virtualisation.memorySize = 1024;
  #virtualisation.vlans = [ 1 2 ];
}
