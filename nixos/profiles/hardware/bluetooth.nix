{ inputs, config, lib, pkgs, ... }:
{
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    #powerOnBoot = true;
  };

}
