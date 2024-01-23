{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Better NixOS option to load these modules?
  # TODO: Configure modules to fix keyboard & mouse gestures?
  boot.availableKernelModules = ["hid_apple" "hid_magicmouse"];
  boot.kernelModules = ["hid_apple" "hid_magicmouse" "mac_hid"];

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
    options hid_apple iso_layout=0
  '';
  boot.kernelParams = ["hid_apple.fnmode=2"];
}
