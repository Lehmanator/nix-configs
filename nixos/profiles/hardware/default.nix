{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    (inputs.self + /nixos/profiles/fwupd.nix)
    (inputs.self + /nixos/profiles/thunderbolt.nix)
    (inputs.self + /nixos/profiles/tlp.nix)
    (inputs.self + /nixos/profiles/usb.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/printers.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/scanners.nix)
    (inputs.self + /nixos/profiles/hardware/wifi.nix)

    #./disks
    #./laptop.nix
    #./tablet.nix
    #./phone.nix
  ];

  environment.systemPackages = [
    pkgs.dmidecode
  ];

}
