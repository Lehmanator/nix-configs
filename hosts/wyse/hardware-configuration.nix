{ inputs
, lib
, modulesPath
, ...
}:
{
  imports = with inputs; [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-hardware.nixosModules.common-cpu-intel
    disko.nixosModules.disko
  ];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "nvme" ];
    };
  };

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault true;

    #bluetooth = {
    #  enable = true;
    #  powerOnBoot = true;
    #};

    # Peripherals
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    # Sensors
    #sensor.iio.enable = true;
  };

  # Enables DHCP on each ethernet & wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  #networking.interfaces.enp0s13f0u2c2.useDHCP = lib.mkDefault true;
  #networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

}
