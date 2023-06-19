{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./common.nix
  ];

  services.esphome = {
    enable = true;
    package = pkgs.esphome;
    openFirewall = true;
    #port = 6052;
    #address = "localhost";
    #enableUnixSocket = true;
    #allowedDevices = [
    #  "char-ttyS"
    #  "char-ttyUSB"
    #  #"/dev/serial/by-id/usb-Silicon_Labs_CP2102_USB_to_UART_Bridge_Controller_0001-if00-port0"
    #];
  };

  services.home-assistant.extraComponents = [ "esphome" ];
}
