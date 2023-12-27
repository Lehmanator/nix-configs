{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    #./crash-dump.nix     # ???
    #./systemd-debug.nix  # ???
  ];

  # --- systemd Emergency Mode ---
  systemd.enableEmergencyMode = true;
  boot.initrd.systemd = {
    emergencyAccess = true;
    enableEmergencyMode = true;
    initrdBin = [ "btrfs" "btrfs-progs" ]; # Packages to include in /bin for the stage 1 emergency shell
    extraBin = [ "btrfs" "btrfs-progs" ]; # Packages to include in /bin for the stage 1 emergency shell
  };

  # Print out default bootloader name & its config
  boot.extraInstallCommands = ''
    default_cfg=$(cat /boot/loader/loader.conf | grep default | awk '{print $2}')
    init_value=$(cat /boot/loader/entries/$default_cfg | grep init= | awk '{print $2}')
    sed -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
  '';
}
