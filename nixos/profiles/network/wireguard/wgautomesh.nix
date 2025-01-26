{
  config,
  lib,
  ...
}: {
  services.wgautomesh = {
    enable = true; # Whether to enable the wgautomesh daemon.
    enableGossipEncryption = true; # Enable encryption of gossip traffic.
    enablePersistence = true; # Enable persistence of Wireguard peer info between restarts.
    gossipSecretFile = config.sops.secrets.wgautomesh-gossip-secret.path; # File for gossip secret, shared secret key for gossip encryption. Required if enableGossipEncryption=true. File may contain any arbitrary-length utf8 str. Generate: `openssl rand -base64 32`
    openFirewall = true; # Automatically open gossip port in firewall (recommended).
    logLevel = "info";

    settings = {
      gossip_port = 1666; # wgautomesh gossip port, this MUST be the same number on all nodes in the wgautomesh network.
      interface = "wg0"; # Wireguard interface to manage (NOT created by wgautomesh, use another NixOS option to create
      lan_discovery = true; # Enable discovery of peers on the same LAN using UDP broadcast.
      upnp_forward_external_port = 42270; # Public port to try to redirect to this machine’s Wireguard daemon using UPnP IGD

      peers = [
        {
          address = "45.42.244.62"; # Wireguard address of this peer (a single IP address, multiple addresses or address ranges are not supported)
          endpoint = "45.42.244.130:51420"; # Bootstrap endpoint for connecting to this peer if no address known or none working
          pubkey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc="; # Wireguard public key of this peer.
        } # sea1 IPv4
        {
          address = "2602:fcc3::c00b";
          endpoint = "45.42.244.130:51420";
          pubkey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
        } # sea1 IPv6
      ];
    };
  };

  # TODO: Secrets with `agenix` or `sops-nix` (gossipSecretFile)
  sops.secrets.wgautomesh-gossip-secret = lib.mkIf config.services.wgautomesh.enableGossipEncryption {};
}
