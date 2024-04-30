{ inputs, config, lib, pkgs, modulesPath, ... }:
let
  rg = lib.getExe pkgs.ripgrep;
  awk = lib.getExe pkgs.gawk;
  sed = lib.getExe pkgs.gnused;
in
{
  systemd.enableEmergencyMode = true;
  boot = {
    initrd.systemd = {
      emergencyAccess = true;
      initrdBin = [ pkgs.btrbk pkgs.btrfs-progs pkgs.btrfs-snap ];
      #extraBin = [ pkgs.btrbk pkgs.btrfs-progs  pkgs.btrfs-snap];
      # Packages to include in /bin for the stage 1 emergency shell
    };

    # Print out default bootloader name & its config
    loader.systemd-boot.extraInstallCommands = ''
      default_cfg=$(cat /boot/loader/loader.conf | ${rg} default | ${awk} '{print $2}')
      init_value=$(cat /boot/loader/entries/$default_cfg | ${rg} init= | ${awk} '{print $2}')
      ${sed} -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
    '';
  };
}
