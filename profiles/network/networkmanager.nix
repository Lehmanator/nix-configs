{ inputs
, self
, config
, lib
, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  networking.networkManager = {
    enable = true;
    enableFccUnlock = true;
    enableStrongSwan = true;

    #appendNammeservers = [
    #];

    # Configuration for [connection] section of NetworkManager.conf
    # See: https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    #connectionConfig = {
    #  #802-1x.auth-timeout =
    #  #cdma.mtu =
    #  #connection.auth-retries = 3;
    #  #autoconnect-slaves =
    #  #mud-url = "none";
    #  lldp = "yes";
    #  llmnr = if config.services.resolved.enable then "yes" else "no";
    #  mdns = "yes";
    #  mptcp-flags = "0x22";  # "enabled,subflow";
    #  dns-over-tls = "yes";
    #  #stable-id = "";
    #  ethernet.cloned-mac-address = "preserved";
    #};

    #dhcp = "internal";  # dhcpcd | internal
    dispatcherScripts = [
      {
        type = "basic";
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
    #dns = "default"; # default | dnsmasq | unbound | systemd-resolved | none

    # Append config to NetworkManager.conf
    #extraConfig = ''
    #'';

    # List of name servers that should be inserted before the ones configured in NetworkManager or received by DHCP
    #insertNameservers = [
    #];

    #logLevel = "WARN";

    #plugins = [
    #];

    # List of interfaces that will not be managed by NetworkManager
    #unmanaged = [
    #];

  };

  users.users."${user}".extraGroups = [ "networkmanager" ];

}
