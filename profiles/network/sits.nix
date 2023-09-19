{ inputs
, config, lib, pkgs
, ...
}:
{
  #networking.sits.ethernet6to4 = { # IPv6 to IPv4 address translation interface
  #  dev = "enp4s0f0";      # Underlying network device on which the tunnel resides
  #  encapsulation = {      # Configures encapsulation in UDP packets
  #    port = 9001;         # Dest port for encapsulated packets
  #    type = "fou";        # Encapsulation type (see: ip-link(8))  # fou | gue
  #    local = "10.0.0.22"; # Addr of local endpoint which the remote side should send packets to.
  #    remote = "10.0.0.1"; # Addr of remote endpoint to forward traffic over.
  #    ttl = 255;           # Time-to-live of connection to tunnel endpoint
  #  };
  #};
}

