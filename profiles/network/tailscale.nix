{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    #./tailscale-personal.nix
    ./tailscale-work.nix
  ];

  # Make the Tailscale command usable to users
  environment.systemPackages = if config.services.xserver.desktopManager.gnome.enable
    then [ pkgs.tailscale pkgs.gnomeExtensions.tailscale-status pkgs.gnomeExtensions.taildrop-send ] #pkgs.trayscale
    else [ pkgs.tailscale ];

  # Enable service: tailscaled
  services.tailscale = {
    enable = true;
    interfaceName = "tailscale0";
    package = pkgs.tailscale;
    permitCertUid = null;          # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    port = 41641;
    useRoutingFeatures = "both";   # Enable subnet routers & exit nodes.  (none|client|server|both)
  };                               #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`

  # Use MagicDNS
  # TODO: Make sure nameserver is always first: 100.100.100.100
  networking.nameservers = [
    "100.100.100.100"
    "1.1.1.1"
  ];
  networking.search = [
    "tail6a8f8.ts.net"
  ];

  # Always allow traffic from Tailscale network
  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  # Allow Tailscale ports through the firewall
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];
}
