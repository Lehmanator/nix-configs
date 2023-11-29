{ inputs
, config
, lib
, pkgs
, ...
}:
{
  #imports = [ ./tailscale.nix ];
  #networking.nameservers = [ ];
  networking.search = [ "tail6a8f8.ts.net" "samlehman.me" "samlehman.dev" ];
  services.tailscale.extraUpFlags = [ "--ssh" ];
}
