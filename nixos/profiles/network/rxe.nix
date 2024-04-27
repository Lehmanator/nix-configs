{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # Remote Direct Memory Access - high-throughput, low-latency connection by directly sharing memory w/o involving the OS of either machine.
  #  UDP port 4791 must be open on the respective ethernet interfaces.
  networking.rxe = {
    enable = true;
    interfaces = [
      #"eth0"           # TODO: Setup eth0 via systemd-networkd
      #"wlp166s0"
    ];
  };

  networking.firewall.allowUDPPorts = [ 4791 ];

}
