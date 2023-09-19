{ inputs
, self
, config
, lib
, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    ./personal.nix
    ./work.nix
  ];

  # Make the Tailscale command usable to users
  environment.systemPackages = [ pkgs.tailscale ]
    ++ lib.optionals config.services.xserver.desktopManager.gnome.enable [
    pkgs.gnomeExtensions.tailscale-status
    pkgs.gnomeExtensions.taildrop-send
    #pkgs.trayscale
  ];

  # Enable service: tailscaled
  services.tailscale = {
    enable = true;
    interfaceName = "tailscale0";
    package = pkgs.tailscale;
    permitCertUid = null; # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    port = 41641;
    useRoutingFeatures = "both"; # Enable subnet routers & exit nodes.  (none|client|server|both)
  }; #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`

  networking = {
    # Use MagicDNS
    # TODO: Make sure nameserver is always first: 100.100.100.100
    nameservers = [ "100.100.100.100" ];

    # Always allow traffic from Tailscale network
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

    # Allow Tailscale ports through the firewall
    firewall.allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
