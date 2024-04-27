{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  #imports = [ ./tailscale.nix ];
  networking = {
    nameservers = [ "10.17.1.81" ];
    search = [ "tail1e7e4.ts.net" ];
  };
  #services.tailscale.extraUpFlags = [ "--ssh" ];
}
