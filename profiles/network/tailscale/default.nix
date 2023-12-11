{ inputs
, config
, lib
, pkgs
, user
, isFunnel ? false
, ...
}:
{
  imports = [
    ./personal.nix
    #./work.nix
  ];
  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [
    #pkgs.gnomeExtensions.taildrop-send
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
  ];

  services.tailscale = {
    enable = true;

    authKeyFile = config.sops.secrets.tailscale-auth-keyfile.path; #"/run/secrets/tailscale0.key";
    extraUpFlags = [ "set --operator=${user}" "--ssh" ];
    interfaceName = "tailscale0";

    openFirewall = true;

    package = pkgs.tailscale;

    # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    # TODO: Dedicated user? ACME user?
    permitCertUid = user; #null;
    port = 41641;
    useRoutingFeatures = "both"; # Enable subnet routers & exit nodes.  (none|client|server|both)
  }; #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`

  sops.secrets.tailscale-auth-keyfile = { };

  # Use MagicDNS
  networking = {
    nameservers = [ "100.100.100.100" ]; # TODO: Make sure nameserver is always first: 100.100.100.100
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ config.services.tailscale.interfaceName ]; # Always allow traffic from Tailscale network
      allowedUDPPorts = [
        config.services.tailscale.port # Allow Tailscale port through the firewall
      ] ++ lib.optionals isFunnel [ 443 8443 10000 ];
    };
  };

  #environment.persistence."/nix/persist".directories = ["/var/lib/tailscale"];
}
