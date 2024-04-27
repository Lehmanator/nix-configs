{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    #./crash-dump.nix  # ???
    #./systemd-emergency.nix  # ???
  ];

  # --- Crash Dumps ---
  boot = {
    crashDump = {
      enable = true;
      kernelParams = [ "1" "boot.shell_on_fail" ]; # TODO: Find list of others
      reservedMemory = "128M";
      initrd.systemd = {
        additionalUpstreamUnits = [
          "debug-shell.service"
          "systemd-quotacheck.service"
        ];
        managerEnvironment.SYSTEMD_LOG_LEVEL = "debug";
      };
    };
    # Print out default bootloader name & its config
    extraInstallCommands = ''
      default_cfg=$(cat /boot/loader/loader.conf | grep default | awk '{print $2}')
      init_value=$(cat /boot/loader/entries/$default_cfg | grep init= | awk '{print $2}')
      sed -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
    '';
  };
}
