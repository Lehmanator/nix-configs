{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  networking.networkManager = {
    enableStrongSwan = true;
    #appendNammeservers = [];

    # Configuration for [connection] section of NetworkManager.conf
    # See: https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    #connectionConfig = {
    #};

    #dhcp = "internal";  # dhcpcd | internal
    dispatcherScripts = [
      { type = "basic";
        source = pkgs.writeText "upHook" ''
          if [ "$2" != "up" ]; then
            logger "exit: event $2 != up"
            exit
          fi
          logger "Device $DEVICE_IFACE coming up"
        '';
      }
    ];

    # Set resolv.conf DNS processing mode
    # See:
    # - https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    # - man NetworkManager.conf(5)
    dns = "default";  # default | dnsmasq | unbound | systemd-resolved | none

    # Append config to NetworkManager.conf
    #extraConfig = ''
    #'';

    firewallBackend = "iptables";  # iptables | nftables | none

    # List of name servers that should be inserted before the ones configured in NetworkManager or received by DHCP
    insertNameservers = [];

    logLevel = "WARN";

    #plugins = [
    #];

    wifi = {
      backend = "wpa_supplicant";  # wpa_supplicant | iwd
      macAddress = "preserve";     # permanent | preserve | random | stable | <MACAddress>
      scanRandMacAddress = true;   # MAC addr randomization during scanning
    };
  };

}
