{
  self,
  system,
  inputs,
  host, userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
  ];

  #networking.wg-quick.interfaces.wg0 = {
  #  
  #};
  networking.wireguard.enable = true;
  networking.wireguard.intefaces.wg0 = {
    allowedIPsAsRoutes = true;      # default: true
    generatePrivateKeyFile = true;  # default: false
    interfaceNamespace = null;      # default: null
    ips = [
      "/24"
    ];
    listenPort = 51820;             # default: null
    mtu = 1420;                     # default: null
    peers = [
    #{ 
    #  allowedIps = [ "<LocalIP>/32" ];
    #  dynamicEndpointRefreshRestartSeconds = 5;  # default: null
    #  dynamicEndpointRefreshSeconds = 0;         # default: 0
    #  endpoint = "<RemoteIP|Hostname>:<Port>";
    #  persistentKeepalive = 25;                  # default: null
    #  presharedKey = null;                       # default: null
    #  presharedKeyFile = "/run/secrets/wireguard-${config.networking.wireguard.interfaces[0]}";                   # default: null
    #  publicKey = "";
    #}
    ];
    postSetup = "";
    postShutdown = "";
    preSetup = "";
    privateKey = "";
    #privateKeyFile = "${host.dirs.secrets}/wireguard-${config.networking.wireguard.interfaces[0]}.privkey";
    socketNamespace = null; # default: null
    table = "main";         # default: "main"
  };

  # Enable Wireguard network manager service
  services.wg-netmanager.enable = true;
}
