{config, lib, pkgs, ...}:
let
  tailnet-mv = "mullvad.ts.net";
  cfg = {
    enable = true;
    magic-dns = true; # TODO: exit node by ip when false
    exit-node = "us-nyc-wg-301";
  };
in
# https://tailscale.com/kb/1258/mullvad-exit-nodes
{
  networking.search = lib.mkAfter [tailnet-mv];
  services.tailscale = {
    extraUpFlags = [
      "--exit-node-allow-lan-access=true"
      "--exit-node=${cfg.exit-node}.${tailnet-mv}"
    ];
  };
}
