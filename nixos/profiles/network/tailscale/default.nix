{ config, lib, pkgs, user, ... }:
let isFunnel = false; in
{
  imports = [ ./personal.nix ];
  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
  ];

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale-auth-keyfile.path; #"/run/secrets/tailscale0.key";
    extraSetFlags = ["--operator ${user}" "--ssh"];
    extraUpFlags  = ["--operator ${user}" "--ssh"];
    interfaceName = "tailscale0";

    openFirewall = true;

    # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    # TODO: Dedicated user? ACME user?
    permitCertUid = user; #null;
    port = 41641;
    useRoutingFeatures = "both"; # Enable subnet routers & exit nodes.  (none|client|server|both)
  };

  sops.secrets.tailscale-auth-keyfile = { };

  networking = {
    nameservers = lib.mkBefore [ "100.100.100.100" ];
    firewall = {
      trustedInterfaces = [ config.services.tailscale.interfaceName ]; # Always allow traffic from Tailscale network
      allowedUDPPorts = lib.mkIf isFunnel [443 8443 10000];
    };
  };
}
