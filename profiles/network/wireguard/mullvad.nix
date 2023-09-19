{ self, inputs
, config, lib, pkgs
, ...
}:
let
  secretsDir = "/etc/wireguard";  #"/run/secrets";  #"/run/agenix";  #"/etc/keys/host/${host.hostname}"

  peer-mullvad-ashburn = {
    allowedIPs = [ "0.0.0.0/0" "::0/0" ];
    endpoint = "198.54.135.130:51820";  #
    persistentKeepalive = 10;           # 25
    publicKey = "TvqnL6VkJbz0KrjtHnUYWvA7zRt9ysI64LjTOx2vmm4=";
  };

  settings-default = {
    allowedIPsAsRoutes = true;
    generatePrivateKey = true;
    mtu = 1420;
  };
  settings-mullvad-ashburn = settings-default // {
    ips = ["192.168.125.1/24"];
    privateKeyFile = "${secretsDir}/mullvad-ashburn.privkey";
    peers = [peer-mullvad-ashburn];
    #listenPort = null; # default: null  (51820)
  };

in
{
  imports = [
    ./default.nix
  ];

  # TODO: Use each host's internal IP address to generate the port it listens on (so routers can route via port)
  # TODO: Switch to using systemd-networkd options: `systemd.network.netdevs` (incompatible with GNOME)
  # TODO: Interface/Networks for each instance of the following items:
  # 1. Clusters             + Aggregate
  #    - Internal           + Aggregate  (one for: administration, ingress, & cluster internal communication)
  #    - External           + Aggregate  (one for: administration, ingress, & cluster internal communication)
  #    - Cloud              + Aggregate  (one for: administration, ingress, & cluster internal communication)
  # 2. LAN Networks         + Aggregate  (one for: administration, ingress, & cluster internal communication)
  #    - Curr LAN
  #    - Home LAN                        (one for: administration, ingress, & cluster internal communication)
  # 3. Host Machines        + Aggregate  (one for: administration, ingress, & cluster internal communication)
  #    - Virtual Machines   + Agreggate  (one for: administration, ingress, & cluster internal communication)
  #    - Container networks + Aggregate  (one for: administration, ingress, & cluster internal communication)
  #    - Localhost
  networking.wireguard.interfaces = {
    # TODO: Set DNS
    wg-mullvad-ashburn = settings-mullvad-ashburn // {
      ips = [ "192.168.126.1/24" ];
    };
    wg-mullvad-ashburn-blocking = settings-mullvad-ashburn // {
      ips = [ "192.168.125.1/24" ];
    };

  };
}
