{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    #./tailscale.nix
  ];

  networking.nameservers = [
    "10.17.1.81"
  ];
  networking.search = [
    "tail1e7e4.ts.net"
  ];
  #services.tailscale.extraUpFlags = [ "--ssh" ];
}
