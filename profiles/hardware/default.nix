{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
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
