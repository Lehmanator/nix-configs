{  config
, lib
, pkgs
, user
, ...
}:
let
  inherit (lib) mkBefore optional optionals;
  hasGnome = config.services.xserver.desktopManager.gnome.enable;
  hasSSH = config.services.openssh.enable;

  tailnet = "tail3dfa6.ts.net";
  tailnets = [tailnet]; # "tail6a8f8.ts.net"];
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
      extraUpFlags = [
        "--operator=${user}"
        "--accept-routes"
      ] ++ optionals hasSSH ["--ssh" "--advertise-tags tag:ssh"]
        ++ optional (config.services.tailscale.useRoutingFeatures == "both") "--accept-routes"
        ++ optional (config.services.tailscale.useRoutingFeatures == "client") "--accept-routes"
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
  networking = with config.services.tailscale; {
    # TODO: Check to make sure nameserver is always first: 100.100.100.100
    nameservers = mkBefore [ "100.100.100.100" ];
    firewall = {
      checkReversePath = "loose"; # Set by module
      trustedInterfaces = [ interfaceName ]; # Always allow traffic from Tailscale network
      allowedUDPPorts = [ port ] ++ optionals isFunnel [ 443 8443 10000 ];
    };
    search = tailnets;
  };

  #environment.persistence."/nix/persist".directories = ["/var/lib/tailscale"];
  environment.systemPackages = [
    pkgs.tailscale
  ] ++ optionals hasGnome [
    #pkgs.gnomeExtensions.taildrop-send
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
  ];
}
