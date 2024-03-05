{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
# LXC - Linux Containers (LXC), provides tools for creating & managing system / application containers on Linux
{
  imports = [
    inputs.self.nixosProfiles.apparmor
  ]; # LXD service complains about missing AppArmor support (WARN)
  #boot.kernelModules = ["vhost_vsock"];         # TODO: Explain why kernel module added
  users.users.${user}.extraGroups = [
    "lxc"
  ]; # users.extraGroups.lxc.members = [user];  users.groups.lxc.members = [user];

  # Hooks that will be placed under /var/lib/libvirt/hooks/lxc.d/ & called for lxc domains begin/end events.
  #   See: https://libvirt.org/hooks.html
  #   TODO: Determine if option should be set here or in LibVirt config
  #virtualisation.libvirtd.hooks.lxc = {
  #};

  virtualisation.lxc = {
    enable = true;
    lxcfs.enable = true; # Enables LXCFS, a FUSE filesystem for LXC.

    # Default config (default.conf) for new containers (i.e. for network config)
    #   Note: Current value is to set containers to use lxcfs, which is enabled below
    #   See: lxc.container.conf(5)
    defaultConfig = "lxc.include = ${pkgs.lxcfs}/share/lxc/config/common.conf.d/00-lxcfs.conf";

    # System-wide LXC config.
    #   See: lxc.system.conf(5).
    #systemConfig = ''
    #'';

    # Config file for managing unprivileged user network administration access in LXC.
    #   See: lxc-usernet(5)
    #usernetConfig = ''
    #'';
  };

  # Disable the DHCP client for any interface whose name matches any of the shell glob patterns in this list.
  #   Purpose is to blacklist virtual interfaces (i.e. those created by Xen, LibVirt, LXC, etc.)
  #networking.dhcpcd.denyInterfaces = [];
}
