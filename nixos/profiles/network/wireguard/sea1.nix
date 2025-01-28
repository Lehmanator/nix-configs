{
  config,
  pkgs,
  ...
}: {
  networking.firewall.allowedUDPPorts = [config.networking.wireguard.wg-sea1.listenPort];
  networking.wireguard.interfaces.wg-sea1 = {
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

  # TODO: Move to kubernetes user profile.
  environment.systemPackages = with pkgs; [kubectl k9s kubernetes-helm];
  sops.secrets.wireguard-sea1-admin-privkey = {};
}
