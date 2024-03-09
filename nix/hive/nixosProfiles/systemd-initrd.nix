{ inputs, config, lib, pkgs, ... }:
{
  boot.initrd.systemd = with config.boot.loader; rec {
    #contents."/etc/hostname".text = config.networking.hostName;
    #enable =  (systemd-boot.enable || lanzaboote.enable); #    # d:false
    enable = systemd-boot.enable;
    enableTpm2 = lib.mkDefault enable;
    emergencyAccess = lib.mkDefault false; # # true=unauthed-emerg-access,<str>=hashed-su-passwd (authed-emerg-access)
    dbus.enable = lib.mkDefault enable;
    #extraBin = { umount=${pkgs.util-linux}/bin/umount; }; #            # Tools to add to `/bin`
    #extraConfig = "DefaultLimitCORE=infinity"; #                       # See: `man systemd-system.conf(5)`
    #initrdBin = []; #                                                  # Packages to include in `/bin` for stage1 emergency shell
    #managerEnvironment = {SYSTEMD_LOG_LEVEL="debug";}; #               # Env vars of PID 1. Not passed to started units.
    #additionalUpstreamUnits=["debug-shell.service" "systemd-quotacheck.service"]; # Enable builtin systemd units
    #packages = [pkgs.systemd-cryptsetup-generator]; # Packages providing systemd units/hooks
  };
}
