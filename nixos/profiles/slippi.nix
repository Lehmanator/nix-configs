{ inputs, config, lib, pkgs, ... }:
{
  imports = [inputs.slippi.nixosModules.default];
  home-manager.sharedModules = [(inputs.self + /hm/profiles/slippi.nix)];
  
  # Enable kernel modules & udev rules for GameCube adapter
  gamecube-controller-adapter = {
    enable = true;
    overclocking-kernel-module = true;
    udev-rules.enable = true;
    # udev-rules.rules = ''
    #   ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="666", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device" TAG+="uaccess"
    # '';
  };
}
