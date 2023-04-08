{ self, inputs, config, lib, pkgs,
  host, network, repo,
  allHosts, allNetworks,
  system      ? "x86_64-linux",
  userPrimary ? "sam",
  ...
}:
let
  secretsDir = "/run/secrets";
  #"/run/agenix"
  #"/etc/wireguard"
  #"/etc/keys/host/${host.hostname}"
  sea1 = if allNetworks ? sea1 then allNetworks.sea1 else rec {
    name = "sea1";
    domain = "samlehman.me";
    ip = {
      addr4 = "45.42.244.62";    mask4 = 32;
      addr6 = "2602:fcc3::c00b"; mask6 = 128;
    };
    services.kubernetes-api = {
      subdomain = "ing.kubernetes.sea1.617a.net";
      port = 51420;
      environment = "prod";
    };
    services.wireguard-internal = {
      subdomain = "wireguard.internal.${name}.${domain}";
      port = 51820;
      environment = "prod";
    };
    services.wireguard-ingress = {
      subdomain = "wireguard.ingress.${name}.${domain}";
      port = 51820;
      environment = "prod";
    };
  };

  peer-admin = {
    allowedIPs = [ "45.42.244.62/32" "2602:fcc3::c00b/128" ];
    endpoint = "45.42.244.130:51420";  # 
    persistentKeepalive = 10;          # 25
    publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
  };
  peer-ingress = {
    allowedIPs = [ "192.168.124.1/24" ];
    endpoint = "${sea1.services.wireguard-ingress.subdomain}:${sea1.services.wireguard-ingress.port}";
    dynamicEndpointRefreshSeconds = 5;
    persistentKeepalive = 25;
  };

  settings-default = { allowedIPsAsRoutes = true; generatePrivateKey = true; mtu = 1420; };
  settings-admin = settings-default // {
    generatePrivateKey = false;
    ips = ["192.168.123.1/24"];
    listenPort = 42270;
    peers = [peer-admin];
  };
  settings-ingress = settings-default // {
    ips = ["192.168.124.1/24"];
    peers = [peer-ingress];
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

    # Seattle Cluster Services
    wg-sea1-ingress = {
      allowedIPsAsRoutes     = true;       # default: true
      generatePrivateKeyFile = true;
      privateKeyFile = "${secretsDir}/wireguard-${sea1.name}-${sea1.services.ingress}.pub";
      ips = [ "192.168.124.1/24" ];
      listenPort = null; # default: null  (51820)
      mtu = 1420;                      # default: null
      peers = [
        { allowedIPs = [ "45.42.244.62/32" "2602:fcc3::c00b/128" ];
          endpoint = "${sea1.services.wireguard-ingress.subdomain}:${sea1.services.wireguard-ingress.port}";
          persistentKeepalive = 25;   # default: null   # 10
          #publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
        }
      ];
    };

    # Seattle Cluster Administration
    wg-sea1-admin = {
      allowedIPsAsRoutes     = true;   # default: true
      generatePrivateKeyFile = false;  # default: 
      ips = [ "192.168.123.1/24" ];
      listenPort = 42270;              # default: null  (51820)
      peers = [{
        allowedIPs = [ "45.42.244.62/32" "2602:fcc3::c00b/128" ];
        endpoint = "45.42.244.130:51420";  # 
        persistentKeepalive = 10;          # 25
        publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
      }];
    };


  };
}
