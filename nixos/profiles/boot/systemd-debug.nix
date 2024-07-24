{ config, lib, pkgs, ... }: {
  boot = {
    crashDump = {
      enable = lib.mkDefault true;

      # TODO: Find list of others
      kernelParams = lib.mkDefault [ "1" "boot.shell_on_fail" ];
      reservedMemory = lib.mkDefault "128M";
    };

    initrd.systemd = {
      additionalUpstreamUnits = lib.mkDefault [ "debug-shell.service" "systemd-quotacheck.service" ];
      managerEnvironment.SYSTEMD_LOG_LEVEL = lib.mkDefault "debug";
    };

    # Print out default bootloader name & its config
    loader.systemd-boot.extraInstallCommands = ''
      default_cfg=$(cat /boot/loader/loader.conf | grep default | awk '{print $2}')
      init_value=$(cat /boot/loader/entries/$default_cfg | grep init= | awk '{print $2}')
      sed -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
    '';
  };
}
