{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
# LXD - Daemon that manages containers. Users in `lxd` group can interact w/ daemon (to start/stop containers) using the `lxc` command line tool & others.
{
  imports = [
    #inputs.self.nixosProfiles.apparmor  # LXD service complains about missing AppArmor support (WARN)
    #./lxc.nix                    # Interfacing w/ LXD can be done w/ LXC (or other utils, but you will probs use LXC)
    #./lxd-image-server.nix       # Creates, manages, & mirrors a simplestreams lxd image server on top of nginx.
  ];

  boot.kernelModules = [
    "vhost_vsock" # Enables the capacity to launch vm with a virtual socket (network)
    "nf_nat_ftp" # Required for NAT forwarding
  ]; # TODO: Explain why kernel module added
  boot.kernel.sysctl = {
    # Enable NAT forwarding for IPv4
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;
  };
  # TODO: Set firewall to allow NAT, make rules for LXC, LXD

  networking.hostId = "aa38a832"; # Required by ZFS. Use: head -c 8 /etc/machine-id

  users.users.${user}.extraGroups = [
    "lxd"
  ]; # users.extraGroups.lxd.members = [user];  users.groups.lxd.members = [user];

  virtualisation.lxd = {
    enable = true;
    agent.enable = true; # Enable LXD agent. Default=false
    #package = pkgs.lxd;                                          # Package for LXD
    lxcPackage =
      pkgs.lxc; # config.virtualisation.lxc.package; # Package for LXC. Required for AppArmor profiles.

    # Enables various settings to avoid common pitfalls when running containers requiring too many file operations. Fixes errors like: "Too many open files" or "neighbour: ndisc_cache: neighbor table overflow".
    #   See: https://lxd.readthedocs.io/en/latest/production-setup/
    recommendedSysctlSettings = true;

    startTimeout =
      180; # LXD daemon in lxd.service will timeout after this many seconds. Default=600
    ui.enable = true; # Experimental UI for LXD  # TODO: Figure out how to use
    #ui.package = pkgs.ui;  #
    zfsSupport =
      false; # config.boot.zfs.enabled;  # Whether ZFS pools are supported. Note: Requires zfsSupport in kernel/initram
  };

  # --- ZFS Storage Pools ---
  # Note: LXD works well with ZFS pools. Add `../../boot/zfs.nix` to imports to enable ZFS.
}
