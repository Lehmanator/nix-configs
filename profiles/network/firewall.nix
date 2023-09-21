{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./iptables.nix
    #./nftables.nix
    #./ufw.nix
  ];

  networking = {
    networkmanager.firewallBackend = "nftables"; # iptables | nftables | none
    nftables.enable = true;
    firewall = {
      enable = true;

      # Allow pings, but not many
      pingLimit =
        if config.networking.nftables.enable
        then "2/minute burst 5 packets"
        else "--limit 2/minute  --limit-burst 5/minute";

    };

  };
}
