{ inputs
, config
, lib
, pkgs
, user
, ...
}:
let
tailnet = "tail3dfa6.ts.net";
tailnets = ["tail3dfa6.ts.net" "tail6a8f8.ts.net"];
isFunnel = false;
isRouter = true;
in
{
  sops.secrets.tailscale-auth-keyfile = { };
  services = {
    nginx.tailscaleAuth.expectedTailnet = tailnet;
    tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale-auth-keyfile.path;
      extraUpFlags = [ "--operator=${user}" ] ++ lib.optional config.services.openssh.enable "--ssh"
        ++ lib.optional (config.services.tailscale.useRoutingFeatures == "both") "--accept-routes"
      ;
      interfaceName = "tailscale0";
      openFirewall = true;
      package = pkgs.tailscale;
      permitCertUid = user;
      port = 41641;
      useRoutingFeatures = if isRouter then "both" else "client"; # Enable subnet routers & exit nodes.  (none|client|server|both)
    }; #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`
  };

  # Use MagicDNS
  networking = {
    nameservers = lib.mkBefore [ "100.100.100.100" ]; # TODO: Make sure nameserver is always first: 100.100.100.100
    firewall = {
      checkReversePath = "loose"; # Set by module
      trustedInterfaces = [ config.services.tailscale.interfaceName ]; # Always allow traffic from Tailscale network
      allowedUDPPorts = [ config.services.tailscale.port ] ++ lib.optionals isFunnel [ 443 8443 10000 ];
    };
    search = tailnets;
  };

  #environment.persistence."/nix/persist".directories = ["/var/lib/tailscale"];
  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [
    #pkgs.gnomeExtensions.taildrop-send
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
  ];
}
