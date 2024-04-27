{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./bluetooth.nix
    #./fprind.nix
    ./fwupd.nix
    #./mobile.nix
    ./power-management.nix
    ./thunderbolt.nix
    #./tpm2.nix
    ./usb.nix
    ./wifi.nix
    #./peripherals/printers.nix
    #./peripherals/scanners.nix

    #./disks
    #./display
    #./touch.nix
    #./laptop.nix
    #./tablet.nix
    #./phone.nix
  ];

  environment.systemPackages = [
    pkgs.dmidecode
  ];

}
