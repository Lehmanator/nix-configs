{
  self,
  system,
  inputs,
  host, network, repo,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  services.tailscale = {
    enable = true;
    interfaceName = "tailscale0";
    package = pkgs.tailscale;
    permitCertUid = null;          # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
    port = 41641;
    useRoutingFeatures = "both";   # Enable subnet routers & exit nodes.  (none|client|server|both)
  };                               #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`
}
