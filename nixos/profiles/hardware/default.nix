{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./fwupd.nix
    ./usb.nix
    #./disks
    #./display
    #./touch.nix
    #./laptop.nix
    #./tablet.nix
    #./phone.nix
  ];

  environment.systemPackages = [
  ];

}
