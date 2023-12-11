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
    #networkmanager.firewallBackend = "nftables"; # iptables | nftables | none  # Compat layer means NetworkManager always uses nftables
    nftables.enable = true;
    firewall = {
      enable = lib.mkDefault true;

      # Allow pings, but not many
      pingLimit =
        if config.networking.nftables.enable
        then "2/minute burst 5 packets"
        else "--limit 2/minute  --limit-burst 5/minute";

    };

  };
}
