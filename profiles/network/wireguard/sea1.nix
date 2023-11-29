{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  networking.firewall.allowedUDPPorts = [ 42270 ]; #config.networking.wireguard.interfaces.wg-sea1
  networking.wireguard.interfaces.wg-sea1 = {
    allowedIPsAsRoutes = true; # default: true
    generatePrivateKeyFile = false; # default:
    privateKeyFile = "/etc/wireguard/sea1-admin.privkey";
    #privateKeyFile = config.sops.secrets.wireguard-sea1-privkey.path;
    listenPort = 42270; # default: null  (51820)
    ips = [ "192.168.123.1/24" ];
    peers = [{
      #allowedIPs = [ "45.42.244.62/32" ]; # "2602:fcc3::c00b/128" ];  # TODO: Check IPv6 CIDR
      allowedIPs = [ "45.42.244.62/32" "2602:fcc3::c00b/128" ];
      endpoint = "45.42.244.130:51420"; #
      persistentKeepalive = 10; # 25
      publicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
    }];
  };
  environment.systemPackages = with pkgs; [ kubectl k9s kubernetes-helm ]; # TODO: Move to kubernetes user profile.
  #sops.secrets = { wireguard-sea1-privkey = {}; wireguard-sea1-pubkey = {}; };
}
