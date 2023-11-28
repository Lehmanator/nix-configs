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
  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [
    #pkgs.gnomeExtensions.taildrop-send
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
    #pkgs.trayscale
  ];

  # Enable service: tailscaled
  services.tailscale = {
    enable = true;
    #authKeyFile = "/run/secrets/tailscale0.key";
    interfaceName = "tailscale0";
    package = pkgs.tailscale;
    permitCertUid = user; #null; # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    port = 41641;
    useRoutingFeatures = "both"; # Enable subnet routers & exit nodes.  (none|client|server|both)
    extraUpFlags = [
      "set --operator=${user}"
      "--ssh"
    ];
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
