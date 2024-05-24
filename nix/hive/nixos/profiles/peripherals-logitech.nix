{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # Logitech unified receiver for wireless peripherals
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = config.services.xserver.enable;
  };
}
