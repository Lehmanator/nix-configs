{ inputs, config, lib, pkgs, ... }: {
  services.wgautomesh = {
    # Whether to enable the wgautomesh daemon.
    enable = true;

    # Enable encryption of gossip traffic.
    enableGossipEncryption = true;

    # Enable persistence of Wireguard peer info between restarts.
    enablePersistence = true;

    # File for gossip secret, shared secret key for gossip encryption. Required if enableGossipEncryption=true. File may contain any arbitrary-length utf8 str. Generate: `openssl rand -base64 32`
    #gossipSecretFile = "/etc/wireguard/wgautomesh-gossip.secret";
    gossipSecretFile = config.sops.secrets.wgautomesh-gossip-secret.path;

    logLevel = "info";

    # Automatically open gossip port in firewall (recommended).
    openFirewall = true;

    settings = {
      # wgautomesh gossip port, this MUST be the same number on all nodes in the wgautomesh network.
      gossip_port = 1666;

      # Wireguard interface to manage (NOT created by wgautomesh, use another NixOS option to create
      interface = "wg0";

      # Enable discovery of peers on the same LAN using UDP broadcast.
      lan_discovery = true;

      # Public port to try to redirect to this machine’s Wireguard daemon using UPnP IGD
      upnp_forward_external_port = 42270;
      # TODO: Abstract & re-use b/w regular wireguard & wgautomesh
      peers = [
        {
          # Wireguard address of this peer (a single IP address, multiple addresses or address ranges are not supported)
          address = "45.42.244.62";

          # Bootstrap endpoint for connecting to this peer if no address known or none working
          endpoint = "45.42.244.130:51420";

          # Wireguard public key of this peer.
          pubkey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
        }
        {
          address = "2602:fcc3::c00b";
          endpoint = "45.42.244.130:51420";
          pubkey = "/XgG41yW5zjQvLJl3D6LKVx5UGMb5vmvQc5GHeW/oFc=";
        }
      ];
    };
  };

  # TODO: Secrets with `agenix` or `sops-nix` (gossipSecretFile)
  sops.secrets.wgautomesh-gossip-secret = { };
}
