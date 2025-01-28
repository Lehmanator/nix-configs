{
  inputs,
  config,
  lib,
  ...
}:
# See: https://nixos.wiki/wiki/WireGuard
# TODO: Layout schema for wireguard interfaces
# - Personal:    wg0 | personal
#   - Peer: k8s API Ingress
#   - Peer: k8s nginx-ingress
#   - Peer: home network
#   - Peer: work network
# - Mullvad USA: mullvad-usa
# - Mullvad EU:  mullvad-eu
# - ...
{
  networking.nftables.enable = true;
  networking.wireguard = {
    enable = true;
    # useNetworkd = true;  # Enabled in 25.05
    interfaces = {
      wg0 = {
        allowedIPsAsRoutes = true;
        generatePrivateKeyFile = false;
        ips = [
          "10.0.1.0/24"
          "fd42:42:42::1/64"
        ];
        listenPort = 42271;
        privateKeyFile = config.sops.secrets.wireguard-wg0-privkey.path;
        peers = [
          {
            # --- Router ---
            # TODO: External IP addresses
            endpoint = "192.168.1.1:51820";
            allowedIPs = ["192.168.0.0/16"];
            publicKey = "j9oRo3iHKygIKuQc0dF6OOkyhA8M2S9bOY6f7C4PgxE=";
          }
          # { # --- Wyse ---
          #   endpoint = "wyse:51820";
          #   allowedIps = ["192.168.1.3/32"];
          # }
          # { allowedIps = [ "<LocalIP>/32" ];
          #   dynamicEndpointRefreshRestartSeconds = 5;  # default: null
          #   dynamicEndpointRefreshSeconds = 0;         # default: 0
          #   endpoint = "<RemoteIP|Hostname>:<Port>";
          #   persistentKeepalive = 25;                  # default: null
          #   presharedKey = null;                       # default: null
          #   presharedKeyFile = "/run/secrets/wireguard-${config.networking.wireguard.interfaces[0]}";                   # default: null
          #   publicKey = "";
          # }
        ];
        # generatePrivateKeyFile = true; # default: false
        # ips = [ "192.168.125.1/24" ];
        # mtu = 1420;                      # default: null
        # interfaceNamespace = null;      # default: null
        # postSetup = "";
        # postShutdown = "";
        # preSetup = "";
        # privateKey = "";
        # socketNamespace = null; # default: null
        # table = "main";         # default: "main"
      };
      wg-sea1 = {
        allowedIPsAsRoutes = true;
        generatePrivateKeyFile = false;
        privateKeyFile = config.sops.secrets.wireguard-sea1-admin-privkey.path;
        listenPort = 42270;
        ips = ["192.168.123.1/24"];
        peers = [
          {
            allowedIPs = ["45.42.244.62/32" "2602:fcc3::c00b/128"];
            endpoint = "45.42.244.130:51420";
            persistentKeepalive = 10;
            publicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
          }
        ];
      };
    };
  };
  networking.networkmanager.ensureProfiles = {
    secrets.entries = [
      {
        file = config.sops.secrets.wireguard-sea1-admin-privkey.path;
        key = "private-key";
        matchId = "wg-sea1";
        matchSetting = "wireguard";
        matchType = "wireguard";
      }
      {
        file = config.sops.secrets.wireguard-wg0-privkey.path;
        key = "private-key";
        matchId = "wg0";
        matchSetting = "wireguard";
        matchType = "wireguard";
      }
    ];
    profiles = {
    };
  };

  networking.firewall = {
    allowedUDPPorts = lib.mapAttrsToList (n: v: v.listenPort) config.networking.wireguard.interfaces;
    logReversePathDrops = true; # if packets still dropped, show in dmesg
    # extraCommands = ''
    #   ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
    #   ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
    # '';
    # extraStopCommands = ''
    #   ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
    #   ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
    # '';
  };

  networking.hosts."45.42.244.130" = ["api.kube.sea1"];

  # networking.wg-quick.interfaces.wg0 = {
  # };

  # Enable Wireguard network manager service
  # https://github.com/gin66/wg_netmanager
  services.wg-netmanager.enable = true;

  sops.secrets = {
    wireguard-wg0-privkey = {
      key = "wg0-privkey";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wireguard.yaml;
    };
    wireguard-sea1-admin-privkey = {
      key = "sea1-admin-privkey";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wireguard.yaml;
    };
  };
}
