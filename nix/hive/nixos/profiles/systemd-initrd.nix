{ config, lib, ... }:
let
  canUse = config.boot.loader.systemd-boot.enable || (config.boot ? "lanzaboot" && config.boot.lanzaboote.enable);
in
{
  boot.initrd.systemd = rec {
    enable = canUse;
    enableTpm2 = lib.mkDefault enable;
    dbus.enable = lib.mkDefault enable;

    # true=unauthed-emerg-access,<str>=hashed-su-passwd (authed-emerg-access)
    emergencyAccess = lib.mkDefault false;

    # Enable builtin systemd units
    # additionalUpstreamUnits=[
    #   "debug-shell.service"
    #   "systemd-quotacheck.service"
    #];

    # contents."/etc/hostname".text = config.networking.hostName;

    # Extra tools to add to `/bin` in initrd
    # extraBin = {
    #   umount=${pkgs.util-linux}/bin/umount;
    # };

    # See: `man systemd-system.conf(5)`
    # extraConfig = "DefaultLimitCORE=infinity"; 

    # Packages to include in `/bin` for stage1 emergency shell
    # initrdBin = [];

    # Env vars of PID 1. Not passed to started units.
    # managerEnvironment = {
    #   SYSTEMD_LOG_LEVEL="debug";
    # };

    # Packages providing systemd units/hooks
    # packages = [pkgs.systemd-cryptsetup-generator];
  };
}
