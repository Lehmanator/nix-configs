{
  config,
  lib,
  ...
}: {
  # Compat layer means NetworkManager always uses nftables
  # options: iptables | nftables | none
  # networkmanager.firewallBackend = "nftables";
  networking.nftables.enable = true;
  networking.firewall = {
    enable = lib.mkDefault true;

    # Allow pings, but not many
    pingLimit =
      if config.networking.nftables.enable
      then "2/minute burst 5 packets"
      else "--limit 2/minute  --limit-burst 5/minute";
  };
}
