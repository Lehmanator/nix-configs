{ self
, inputs
, config
, lib
, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  networking.wireguard.interfaces.wg-sea1 = {
    allowedIPsAsRoutes = true; # default: true
    generatePrivateKeyFile = false; # default:
    privateKeyFile = "/etc/wireguard/sea1-admin.privkey";
    listenPort = 42270; # default: null  (51820)
    ips = [
      "192.168.123.1/24"
    ];
    peers = [{
      #allowedIPs = [ "45.42.244.62/32" ]; # "2602:fcc3::c00b/128" ];  # TODO: Check IPv6 CIDR
      allowedIPs = [ "45.42.244.62/32" "2602:fcc3::c00b/128" ];
      endpoint = "45.42.244.130:51420"; #
      persistentKeepalive = 10; # 25
      publicKey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
    }];
  };

  networking.firewall.allowedUDPPorts = [
    #config.networking.wireguard.interfaces.wg-sea1
    42270
  ];


  # TODO: Move to kubernetes user profile.
  environment.systemPackages = [
    pkgs.kubectl
    pkgs.k9s
    pkgs.kubernetes-helm
    #pkgs.helm  # Some audio program?
  ];

}
