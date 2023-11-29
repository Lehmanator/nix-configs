{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [ ./personal.nix ./work.nix ];
  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [
    #pkgs.gnomeExtensions.taildrop-send
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
  ];

  services.tailscale = {
    enable = true;
    #authKeyFile = config.sops.secrets.tailscale-auth-key.path; #"/run/secrets/tailscale0.key";
    interfaceName = "tailscale0";
    package = pkgs.tailscale;
    permitCertUid = user; #null; # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    port = 41641;
    useRoutingFeatures = "both"; # Enable subnet routers & exit nodes.  (none|client|server|both)
    extraUpFlags = [ "set --operator=${user}" "--ssh" ];
  }; #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`

  # Use MagicDNS
  networking = {
    nameservers = [ "100.100.100.100" ]; # TODO: Make sure nameserver is always first: 100.100.100.100
    firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ]; # Always allow traffic from Tailscale network
    firewall.allowedUDPPorts = [ config.services.tailscale.port ]; # Allow Tailscale ports through the firewall
  };

  #sops.secrets.tailscale-auth-key = {};
}
