{ inputs
, config, lib, pkgs
, ...
}:
let
  use-systemd = config.systemd.network.enable;
in
{
  imports = [
  ];

  networking.interfaces.eth0 = lib.mkIf (!use-systemd) {

    ipv4.addresses = [
      { address = "192.168.1.3"; prefixLength = 25; }
    ];
    ipv4.routes = [
    ];

    ipv6.addresses = [
    ];
    ipv6.routes = [
    ];

  };

  systemd.network.netdevs = lib.mkIf use-systemd {
    eth0 = {
      enable = true;
      batmanAdvancedConfig = {
        GatewayMode = "server";
        RoutingAlgorithm = "batman-v";
      };
      bondConfig = {
      };

    };
  };

}
