{ config, lib, pkgs, user, ... }:
let
  cfg = {
    magicDns = true;
    # TODO: lib.concatMapSep ","
    subnets = [ "192.168.0.0/24" "192.168.1.0/24" ];
    userspace = false;
    client = true;
  };
in
{
  #config = lib.mkIf cfg.enable {

  #boot.kernel.sysctl = {
  #  "net.ipv4.ip_forward" = 1;
  #  "net.ipv6.conf.all.forwarding" = 1;
  #};

  services.tailscale = {
    enable = true;

    # TODO: Optionally enable VM networks
    # TODO: Optionally enable docker networks
    #"--advertise-exit-node" #"--exit-node"
    extraUpFlags = [ "--advertise-routes=192.168.0.0/24,192.168.1.0/24" ];

    interfaceName =
      if cfg.userspace then "userspace-networking" else "tailscale0";
    openFirewall = true;
    permitCertUid = user;
    useRoutingFeatures =
      if cfg.client then "both" else "server"; # none|client|server|both
  };

  environment.systemPackages = [
    pkgs.tailscale
    #(pkgs.writeScript "tailscale-cert" ''
    #  sudo ${lib.getExe pkgs.tailscale} cert ${config.networking.hostName}
    #'')
  ];

  #};
  # TODO: Make into a module.
  #let cfg=config.tailscale-subnet-router; in {}
  #options.tailscale-subnet-router = {
  #  enable = lib.mkEnableOption "tailscale subnet router";
  #  subnet = lib.mkOption {
  #    type = lib.types.str;
  #    description = "CIDR of the subnet to advertise routes for";
  #    default = "192.168.0.0/24";
  #  };
  #  tailnet = lib.mkOption {
  #    type = lib.types.str;
  #    description = "The name of your tailnet";
  #    example = "tail39jv2.ts.net";
  #    default = "";
  #  };
  #  userspace = lib.mkOptions {
  #    type = lib.types.bool;
  #    description = "Whether to use userspace networking instead of TUN";
  #    default = false;
  #  };
  #};
}
