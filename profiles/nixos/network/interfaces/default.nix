{ inputs
, ...
}:
{
  imports = [
    ./eth0.nix
    #./wlan0.nix
  ];

  # Config for each network interface
  # - Note: if `networking.useDHCP = true` then every interface not listed here will be configured using DHCP.
  # - Note: `systemd.network.netdevs` has more features is better maintained. Advised to use instead
  #networking.interfaces = {
  #};
}
