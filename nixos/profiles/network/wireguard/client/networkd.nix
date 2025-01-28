{config, ...}: {
  boot.extraModulePackages = [config.boot.kernelPackages.wireguard];
  systemd.network.netdevs = {
    "10-sea1" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "sea1";
        MTUBytes = "1300";
      };
      # See also man systemd.netdev (also contains info on the permissions of the key files)
      wireguardConfig = {
        PrivateKeyFile = config.sops.secrets.wireguard-sea1-admin-privkey.path;
        ListenPort = 42270;
      };
      wireguardPeers = [
        {
          wireguardPeerConfig = {
            PublicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
            AllowedIPs = ["45.42.244.62/32" "2602:fcc3::c00b/128"];
            Endpoint = "45.42.244.130:51420";
            PersistentKeepalive = 10;
          };
        }
      ];
    };
  };

  systemd.networks.wg0 = {
    # See also man systemd.network
    matchConfig.Name = "sea1";
    # IP addresses the client interface will have
    address = [
      "192.168.123.1/24"
      "fe80::3/64"
      "fc00::3/120"
      "10.100.0.2/24"
    ];
    DHCP = "no";
    dns = ["fc00::53"];
    ntp = ["fc00::123"];
    gateway = [
      "fc00::1"
      "10.100.0.1"
    ];
    networkConfig = {
      IPv6AcceptRA = false;
    };
  };
}
