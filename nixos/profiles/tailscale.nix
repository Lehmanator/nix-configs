{
  config,
  lib,
  pkgs,
  user,
  ...
}: let
  work = false;

  isFunnel = false;
  isRouter = true;
  isExitNode = true;
  hasMullvad = true;

  tags = lib.concatStringsSep "," (builtins.map (t: "tag:" + t) (
    ["nixos"]
    ++ lib.optional config.services.openssh.enable "ssh"
  ));

  # tailnet-publicSam = "tail6a8f8.ts.net";
  # tailnet-work = "tail1e7e4.ts.net";
  tailnet = "tail3dfa6.ts.net";
  tailnets = [tailnet];
in {
  services.tailscale = rec {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale-auth-keyfile.path;
    interfaceName = "tailscale0";
    port = 41641;
    openFirewall = true;
    extraDaemonFlags = [
      "-no-logs-no-support"
      # "-outbound-http-proxy-listen 'localhost:8080'"
      # "-socks5-server 'localhost:1080'"
    ];
    permitCertUid = user;
    extraSetFlags =
      ["--operator ${user}"]
      ++ lib.optionals (useRoutingFeatures == "both" || useRoutingFeatures == "server") [
        "--advertise-exit-node" # offer to be exit node internet traffic for tailnet
        "--advertise-connector" # offer to be app connector for domain specific internet traffic for tailnet
      ];
    extraUpFlags =
      ["--operator ${user}"]
      ++ [
        "--advertise-tags ${tags}"
        "--webclient"

        # source NAT traffic to local routes advertised with --advertise-routes
        # "--snat-subnet-routes"

        # routes to advertise to other nodes (comma-sep CIDRs)
        "--advertise-routes 10.0.0.0/8,192.168.0.0/24"
      ]
      ++ lib.optional config.services.openssh.enable "--ssh"
      ++ lib.optional isExitNode "--exit-node-allow-lan-access"
      ++ lib.optional hasMullvad "--exit-node us-nyc-wg-301"
      ++ lib.optionals (useRoutingFeatures == "both" || useRoutingFeatures == "client") [
        # accept DNS configuration from admin panel
        "--accept-dns"

        # accept routes advertised by other Tailscale nodes
        "--accept-routes"
      ];

    # Enable subnet routers & exit nodes.
    # options: none | client | server | both
    useRoutingFeatures =
      if isRouter
      then "both"
      else "client";
  };

  # Use MagicDNS
  networking.nameservers = lib.mkBefore (["100.100.100.100"] ++ (lib.optional work "10.17.1.81"));
  networking.search = tailnets;
  networking.firewall = {
    trustedInterfaces = [config.services.tailscale.interfaceName];
    allowedUDPPorts = lib.mkIf isFunnel [443 8443 10000];
  };
  networking.hosts = {
    # --- Tailscale Devices ---
    # TODO: Make parallel with home network
    # TODO: Reassign IP addresses in Tailscale admin UI
    # TODO: Better organization scheme
    "100.100.1.1" = ["cheetah.tailnet"];
    # "100.100.1.2"     = [   "flame.tailnet"];

    # "100.100.1.10"    = [ "fajita0.tailnet"];
    # "100.100.1.11"    = [ "fajita1.tailnet"];
    # "100.100.1.12"    = [   "taba8.tailnet"];

    # "100.100.1.1"     = ["router.tailnet"];
    # "100.100.1.10"    = [  "rpi3.tailnet"];
    # "100.100.1.20"    = [  "wyse.tailnet"];
    # "100.100.1.21"    = [   "aio.tailnet"];
    "100.100.245.120" = ["wyse.tailnet"];
    "100.65.77.40" = ["fw.tailnet"];
    "100.64.49.109" = ["fajita0.tailnet"];
  };

  services.tailscaleAuth.enable = true;
  services.nginx.tailscaleAuth.expectedTailnet = tailnet;

  sops.secrets.tailscale-auth-keyfile = {};

  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [
    pkgs.trayscale
    pkgs.gnomeExtensions.tailscale-qs
    pkgs.gnomeExtensions.tailscale-status
  ];
  home-manager.sharedModules = [
    ({pkgs, ...}: {
      home.packages = [pkgs.trayscale];
      programs.vscode.extensions = [pkgs.vscode-extensions.tailscale.vscode-tailscale];
      programs.gnome-shell.extensions = [
        {package = pkgs.gnomeExtensions.tailscale-qs;}
        {package = pkgs.gnomeExtensions.tailscale-status;}
        {package = pkgs.gnomeExtensions.taildrop-send;}
      ];
    })
  ];
}
