{ config, ... }:
{
  # Print out default bootloader name & its config
  boot.extraInstallCommands = ''
    default_cfg=$(cat /boot/loader/loader.conf | grep default | awk '{print $2}')
    init_value=$(cat /boot/loader/entries/$default_cfg | grep init= | awk '{print $2}')
    sed -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
  '';
}
