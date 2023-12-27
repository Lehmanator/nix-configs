{ inputs, config, lib, pkgs, ... }:
{
  imports = [
  ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

}
