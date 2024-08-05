{ config, lib, pkgs, user, ... }:
let
  inherit (lib) concatStringsSep mkBefore mkIf optional optionals;

  tailnet = "tail3dfa6.ts.net";
  tailnets = [tailnet]; # "tail6a8f8.ts.net"];
  isFunnel = false;
  isRouter = true;
in
{
  sops.secrets.tailscale-auth-keyfile = { };
  services = {
    nginx.tailscaleAuth.expectedTailnet = tailnet;
    tailscale = let
      tags = concatStringsSep "," (builtins.map (t: "tag:"+t) (["nixos"]
        ++ optional config.services.openssh.enable "ssh"
      ));
    in rec {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale-auth-keyfile.path;
      extraDaemonFlags = [ "-no-logs-no-support" ];
        # "-outbound-http-proxy-listen 'localhost:8080'"
        # "-socks5-server 'localhost:1080'"

      # NOTE: 24.11 enables `extraSetFlags`
      extraUpFlags  = 
        # extraUpFlags =
        [ "--operator ${user}" ]
        # extraSetFlags =
        ++ [
        # "--snat-subnet-routes"  # source NAT traffic to local routes advertised with --advertise-routes
        "--advertise-routes 10.0.0.0/8,192.168.0.0/24" # routes to advertise to other nodes (comma-sep CIDRs)
        "--advertise-tags ${tags}"
        "--operator ${user}"
        "--webclient"
      ] ++ optional config.services.openssh.enable "--ssh"
        ++ optionals (useRoutingFeatures=="both" || useRoutingFeatures=="client") [
        "--accept-dns"          # accept DNS configuration from admin panel
        "--accept-routes"       # accept routes advertised by other Tailscale nodes
        "--exit-node-allow-lan-access"
        "--exit-node us-nyc-wg-301"
      ] ++ optionals (useRoutingFeatures=="both" || useRoutingFeatures=="server") [
        "--advertise-exit-node" # offer to be exit node internet traffic for tailnet
        "--advertise-connector" # offer to be app connector for domain specific internet traffic for tailnet
      ];
      interfaceName = "tailscale0";
      openFirewall = true;
      permitCertUid = user;
      port = 41641;
      useRoutingFeatures = if isRouter then "both" else "client"; # Enable subnet routers & exit nodes.  (none|client|server|both)
    };
  };

  # Use MagicDNS
  networking = {
    nameservers = mkBefore [ "100.100.100.100" ];
    search = tailnets;
    firewall = {
      # Always allow traffic from Tailscale network
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      allowedUDPPorts   = mkIf isFunnel [ 443 8443 10000 ];
    };
  };

  environment.systemPackages = []
    ++ optionals config.services.xserver.desktopManager.gnome.enable [
      pkgs.gnomeExtensions.tailscale-qs
      pkgs.gnomeExtensions.tailscale-status
      # pkgs.gnomeExtensions.taildrop-send
      # pkgs.vscode-extensions.tailscale.vscode-tailscale
    ];
}
