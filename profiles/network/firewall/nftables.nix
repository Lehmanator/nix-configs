{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  networking.networkManager.firewallBackend = "nftables"; # iptables | nftables | none

}
