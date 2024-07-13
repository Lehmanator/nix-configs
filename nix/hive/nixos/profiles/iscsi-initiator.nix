{ cell , config, lib, pkgs , ... }:
{
  imports = [
    cell.nixosProfiles.systemd-initrd
    #cell.nixosProfiles.systemd-networkd
  ];

  boot.iscsi-initiator = {
    discoverPortal = "10.17.1.1:3260";     # iSCSI portal to boot from

    # Extra lines to append to /etc/iscsid.conf
    #extraConfig = ''
    #'';

    # Append attitional file to /etc/iscsid.conf.  Use non-store path & store passwords in this file.
    #  Note: File specified here must be avail in the initrd. See: `boot.initrd.secrets`
    extraConfigFile = "./iscsid-extra.conf";

    # Extra ISCSI commands to run in the initrd
    extraIscsiCommands = ''
    '';
    logLevel = 1;   #8;  # Higher=more logs
    loginAll = false;    # Do not log into a specific target on the portal, but to all that we discover. This overrides setting target.
    name = "iqn.2020-08.org.linux.iscsi.initiatorhost:example"; # Name of the iSCSI initiator to boot from. Note: booting from iscsi requires networkd based networking.
    target = "iqn.2020-08.org.linux-iscsi.targethost:example";  # Name of the iSCSI target to boot from.

  };
}
