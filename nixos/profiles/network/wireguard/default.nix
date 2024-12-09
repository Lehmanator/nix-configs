{ inputs
, config, lib, pkgs
, ...
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
  imports = [
    #inputs.sops-nix.nixosModules.sops
    #./backends/generic.nix
    #./backends/networkmanager.nix
    #./backends/systemd-networkd.nix
    #./peers/mullvad.nix
    #./peers/mullvad-ashburn-adblock.nix
    #./peers/sea1.nix
    ./sea1.nix
    ./wgautomesh.nix
    #./wg-netmanager.nix
  ];

  # Fixes IPv6-based exit node servers
  # TODO: Move to server config
  # TODO: Make lan-home wireguard interface
  networking.nftables.enable = true;
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      privateKeyFile = config.sops.secrets.wireguard-wg0-privkey.path;
      listenPort = 51820;
      ips = [
        "10.0.1.0/24"
        "fd42:42:42::1/64"
      ];
      peers = [
        # { endpoint = "45.42.244.130:51420";
        #   allowedIPs = ["45.42.244.62/32" "2602:fcc3::c00b/128"];
        #   persistentKeepalive = 10;
        #   publicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
        # }
        { # --- Router ---
          endpoint = "192.168.1.1:51820";  # TODO: External IP addresses
          allowedIPs = ["192.168.0.0/16"]; # TODO: External IP addresses
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
      # allowedIPsAsRoutes = true; # default: true
      # generatePrivateKeyFile = true; # default: false
      # ips = [ "192.168.125.1/24" ];
      # #listenPort = 42270;              # default: null  (51820)
      # #mtu = 1420;                      # default: null
      # #interfaceNamespace = null;      # default: null
      # #postSetup = "";
      # #postShutdown = "";
      # #preSetup = "";
      # #privateKey = "";
      # #socketNamespace = null; # default: null
      # #table = "main";         # default: "main"
    };
  };

  networking.firewall = {
    allowedUDPPorts = let
      wg-ports = lib.mapAttrsToList (n: v: v.listenPort) config.networking.wireguard.interfaces;
    in [ 42270 42271 42272 42273 42274 42275 ] ++ wg-ports;
    logReversePathDrops = true; # if packets still dropped, show in dmesg
    #extraCommands = ''
    #  ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
    #  ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
    #'';
    #extraStopCommands = ''
    #  ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
    #  ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
    #'';
  };
  #networking.wg-quick.interfaces.wg0 = {
  #};

  # Enable Wireguard network manager service
  # https://github.com/gin66/wg_netmanager
  services.wg-netmanager.enable = true;

  sops.secrets.wireguard-wg0-privkey = {};
}
