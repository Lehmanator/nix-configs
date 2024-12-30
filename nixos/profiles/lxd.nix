{ inputs, config, lib, pkgs, user, ... }:
{
  # LXD - Daemon that manages containers. 
  #  Users in `lxd` group can interact w/ daemon (to start/stop containers)
  #   using the `lxc` command line tool & others.
  # TODO: Set firewall to allow NAT, make rules for LXC, LXD

  imports = [
    # LXD service complains about missing AppArmor support (WARN)
    (inputs.self + /nixos/profiles/apparmor.nix)  

    # Interfacing w/ LXD can be done w/ LXC (or other utils, but you will probs use LXC)
    # (inputs.self + /nixos/profiles/lxc.nix)      

    # Creates, manages, & mirrors a simplestreams lxd image server on top of nginx.
    # (inputs.self + /nixos/profiles/lxd-image-server.nix)  
  ];

  # TODO: Explain why kernel module added
  boot.kernelModules = [
    "vhost_vsock"    # Enables capacity to launch VM w/ a virtual socket (network)
    "nf_nat_ftp"     # Required for NAT forwarding
  ];

  # Enable NAT forwarding for IPv4
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;
  };

  # Required by ZFS.
  #  Use: $ head -c 8 /etc/machine-id
  # TODO: Set per-machine / generate from hostName or machine-id
  networking.hostId = lib.mkDefault "aa38a832";

  users.users.${user}.extraGroups = ["lxd"];
  # users.extraGroups.lxd.members = [user];
  # users.groups.lxd.members = [user];

  virtualisation.lxd = {
    enable = true;
    agent.enable = true; # Enable LXD agent. Default=false
    #package = pkgs.lxd;                                          # Package for LXD

    # Package for LXC.
    # Required for AppArmor profiles.
    lxcPackage = lib.mkDefault pkgs.lxc; # config.virtualisation.lxc.package; 

    # Enables various settings to avoid common pitfalls when running containers requiring too many file operations.
    #  Fixes errors like: "Too many open files" or "neighbour: ndisc_cache: neighbor table overflow".
    #   See: https://lxd.readthedocs.io/en/latest/production-setup/
    recommendedSysctlSettings = true;

    startTimeout = 180; # LXD daemon in lxd.service will timeout after this many seconds. Default=600

    # TODO: Figure out how to use
    # Experimental UI for LXD  
    #ui.package = pkgs.ui;  #
    ui.enable = true; 

    # Whether ZFS pools are supported.
    # Note: Requires zfsSupport in kernel/initram
    zfsSupport = lib.mkIf config.boot.zfs.enabled false;  # config.boot.zfs.enabled;  
  };

  # --- ZFS Storage Pools ---
  # Note: LXD works well with ZFS pools. Add `../../boot/zfs.nix` to imports to enable ZFS.
}
