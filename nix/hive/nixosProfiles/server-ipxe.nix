{
  self, modulesPath,
  inputs, outputs,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
    ./samba.nix
    #./tftpd.nix
  ];


  # --- TFTPd ---
  # For tftpd
  services.tftpd.enable = true;
  services.tftpd.path = "/srv/tftp";

  # For advanced tftpd
  services.atftpd.enable = true;
  services.atftpd.root = "/srv/tftp";
  services.atftpd.extraOptions = [
    "--bind-address 192.168.9.1"
    "--verbose=7"
  ];

  # --- iPXE ---
  services.pixiecore.enable = true;
  services.pixiecore.apiServer = "localhost:8080";
  services.pixiecore.cmdline = "";
  services.pixiecore.debug = true;
  services.pixiecore.dhcpNoBind = true;
  services.pixiecore.extraArguments = [];
  services.pixiecore.initrd = "";  # initrd path
  services.pixiecore.kernel = "";  # kernel path
  services.pixiecore.listen = "0.0.0.0";
  services.pixiecore.mode = "boot";   # "api", "boot", "quick"
  services.pixiecore.openFirewall = true;
  services.pixiecore.port = 80;       # HTTP listening port
  services.pixiecore.quick = "xyz";   # "arch", "centos", "coreos", "debian", "fedora", "ubuntu", "xyz"
  services.pixiecore.statusPort = 80; # HTTP status port (can be same as listen port)

  
  # --- Clients --------------------------------------------
  # On iPXE client machines

  # iPXE in GRUB2
  #boot.loader.grub.ipxe = {
  #  demo = ''
  #    #!ipxe
  #    dhcp
  #    chain http://boot.ipxe.org/demo/boot.php
  #  '';
  #};

  # Netboot XYZ in systemd-boot
  #boot.loader.systemd-boot.netbootxyz.enable = true;
  #boot.loader.systemd-boot.netbootxyz.entryFilename = "o_netbootxyz.conf";
  # MemTest86 (unfree)
  #boot.loader.systemd-boot.memtest86.enable = true;
  #boot.loader.systemd-boot.memtest86.entryFilename = "p_memtest86.conf";

  # OpenVPN in initrd
  #boot.initrd.openvpn.enable = true;
  #boot.initrd.openvpn.configuration = ./configuration.ovpn;

  # Networking in initrd
  #boot.initrd.network.enable = true;
  # CLI args passed to udhcpc if boot.initrd.network.enable = true && networking.useDHCP = true
  ##boot.initrd.network.udhcpc.extraArgs = [];  
  #networking.useDHCP = true;
  #hardware.wirelessRegulatoryDatabase = true;

  # --- iSCSI ---
  boot.iscsi-initiator.discoverPortal = "192.168.1.1:3200";
  boot.iscsi-initiator.extraConfig = ''
  '';  # Insert agenix/sops-nix secrets in here...or use `extraConfigFile` & put in `boot.initrd.secrets`
  boot.iscsi-initiator.extraIscsiCommands = ''
  '';
  boot.iscsi-initiator.logLevel = 1;
  boot.iscsi-initiator.loginAll = false;
  # Name of iSCSI initiator to boot from (requires networkd-based networking)
  boot.iscsi-initiator.name = "iqn.2020-08.org.linux-iscsi.initiatorhost:example";
  # Name of the iSCSI target to boot from
  boot.iscsi-initiator.target = "iqn.2020-08.org.linux-iscsi.targetHost:example";

}
