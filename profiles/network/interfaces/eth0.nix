{ config, lib
, ...
}:
{
  networking.interfaces.eth0 = lib.mkIf (!config.systemd.network.enable) {

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

}
