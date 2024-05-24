{
  config,
  lib,
  ...
}:
# TODO: Move sea1 config to inputs.self+/nix/kube/nixosProfiles/systemd-networkd-wireguard-sea1.nix
{
  #boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

  sops.secrets = {
    wireguard-peer-sea1-privkey = {};
    wireguard-interface-sea1-privkey = {
      sopsFile = ../wireguard/default.yaml;
      path = "/etc/wireguard/sea1.privkey";
    };
    wireguard-interface-mullvad-privkey = {
      sopsFile = ../wireguard/mullvad-${config.networking.hostName}.yaml;
      path = "/etc/wireguard/mullvad.privkey"; # "%r/wireguard-mullvad.privkey";
    };
  };

  systemd.network = lib.mkIf config.networking.wireguard.enable {
    enable = true;
    netdevs = {
      "10-wireguard-mullvad" = {};
      "10-wireguard-sea1" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wireguard-sea1";
          MTUBytes = "1300";
        };
        wireguardConfig = {
          PrivateKeyFile =
            config.sops.secrets.wireguard-interface-sea1-privkey.path;
          ListenPort = 42270;
        };
        wireguardPeers = [
          {
            wireguardPeerConfig = {
              PublicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
              AllowedIPs = ["45.42.244.62/32" "2602:fcc3::c00b/128"];
              Endpoint = "45.42.244.130:51420";
            };
          }
        ];
      };
      #"10-wg0" = {
      #  netdevConfig = {
      #    Kind = "wireguard";
      #    Name = "wg0";
      #    MTUBytes = "1300";
      #  };
      #  # See: `man systemd.netdev` (also contains info on the permissions of the key files)
      #  wireguardConfig = {
      #    # Don't use a file from the Nix store as these are world readable.
      #    PrivateKeyFile = "/run/keys/wireguard-privkey";
      #    PrivateKeyFile = "/etc/wireguard/sea1-admin.privkey";
      #    ListenPort = 42270; #9918;
      #  };
      #};
    };

    networks = {
      # See: `man systemd.network`
      wireguard-sea1 = {matchConfig.Name = "wireguard-sea1";};
      wireguard-mullvad = {matchConfig.Name = "wireguard-mullvad";};
      wg0 = {
        matchConfig.Name = "wg0";
        # IP addresses the client interface will have
        address = ["fe80::3/64" "fc00::3/120" "10.100.0.2/24"];
        DHCP = "no";
        dns = ["fc00::53"];
        ntp = ["fc00::123"];
        gateway = ["fc00::1" "10.100.0.1"];
        networkConfig = {IPv6AcceptRA = false;};
      };
    };
  };
}
