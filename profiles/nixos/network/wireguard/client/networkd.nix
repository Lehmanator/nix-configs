{ config
, pkgs
, lib
, ...
}:
{
  boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1300";
        };
        # See also man systemd.netdev (also contains info on the permissions of the key files)
        wireguardConfig = {
          # Don't use a file from the Nix store as these are world readable.
          #PrivateKeyFile = "/run/keys/wireguard-privkey";
          PrivateKeyFile = "/etc/wireguard/sea1-admin.privkey";
          #ListenPort = 9918;
          ListenPort = 42270;
        };
        wireguardPeers = [{
          wireguardPeerConfig = {
            PublicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
            allowedIPs = [ "45.42.244.62/32" "2602:fcc3::c00b/128" ];
            Endpoint = "45.42.244.130:51420"; #
            #AllowedIPs = [ "fc00::1/64" "10.100.0.1" ];
            #Endpoint = "{set this to the server ip}:51820";
          };
        }];
      };
    };

    networks.wg0 = {
      # See also man systemd.network
      matchConfig.Name = "wg0";
      # IP addresses the client interface will have
      address = [
        "fe80::3/64"
        "fc00::3/120"
        "10.100.0.2/24"
      ];
      DHCP = "no";
      dns = [ "fc00::53" ];
      ntp = [ "fc00::123" ];
      gateway = [
        "fc00::1"
        "10.100.0.1"
      ];
      networkConfig = {
        IPv6AcceptRA = false;
      };
    };
  };

}
