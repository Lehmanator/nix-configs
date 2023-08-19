{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
# LXD - Daemon that manages containers. Users in `lxd` group can interact w/ daemon (to start/stop containers) using the `lxc` command line tool & others.
{
  imports = [
    #../../apparmor.nix      # LXD service complains about missing AppArmor support (WARN)
    #./lxc.nix               # Interfacing w/ LXD can be done with LXC (or other utils, but you will likely use LXC)
    #./lxd-image-server.nix  # Creates, manages, & mirrors a simplestreams lxd image server on top of nginx.
  ];

  boot.kernelModules = ["vhost_vsock"];         # TODO: Explain why kernel module added
  users.users."${user}".extraGroups = ["lxd"];  #users.extraGroups.lxd.members = [user];  users.groups.lxd.members = [user];

  virtualisation.lxd = {
    enable = true;
    package = pkgs.lxd;                                          # Package for LXD
    lxcPackage = pkgs.lxc;   #config.virtualisation.lxc.package; # Package for LXC

    # Enables various settings to avoid common pitfalls when running containers requiring too many file operations. Fixes errors like: "Too many open files" or "neighbour: ndisc_cache: neighbor table overflow".
    #   See: https://lxd.readthedocs.io/en/latest/production-setup/
    recommendedSysctlSettings = true;

    startTimeout = 600;     # LXD daemon in lxd.service will timeout after this many seconds
    ui.enable = true;       # Experimental UI for LXD  # TODO: Figure out how to use
    #ui.package = pkgs.ui;   #
    zfsSupport = false;     # Whether ZFS pools are supported. Note: Requires zfsSupport in kernel/initram
  };
}
