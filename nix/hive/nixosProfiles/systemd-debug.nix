{ inputs, config, lib, pkgs, modulesPath, ... }:
let
  rg = lib.getExe pkgs.ripgrep;
  awk = lib.getExe pkgs.gawk;
  sed = lib.getExe pkgs.gnused;
in
{
  # --- Crash Dumps ---
  boot = {
    crashDump = {
      enable = true;
      kernelParams = [ "1" "boot.shell_on_fail" ]; # TODO: Find list of others
      kernelPatches = [{
        name = "crashdump-config";
        patch = null;
        extraConfig = ''
          CRASH_DUMP y
          DEBUG_INFO y
          PROC_VMCORE y
          LOCKUP_DETECTOR y
          HARDLOCKUP_DETECTOR y
        '';
      }];
      reservedMemory = "128M";
      initrd.systemd = {
        additionalUpstreamUnits =
          [ "debug-shell.service" "systemd-quotacheck.service" ];
        managerEnvironment.SYSTEMD_LOG_LEVEL = "debug";
      };
    };

    # Print out default bootloader name & its config
    extraInstallCommands = ''
      default_cfg=$(cat /boot/loader/loader.conf | ${rg} default | ${awk} '{print $2}')
      init_value=$(cat /boot/loader/entries/$default_cfg | ${rg} init= | ${awk} '{print $2}')
      ${sed} -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
    '';
  };
}
