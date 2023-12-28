{ inputs, config, lib, pkgs, ... }:
{
  # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
  # TODO: Move storage controllers elsewhere
  boot.initrd.availableKernelModules = [
    "xhci_pci" #  # USB 3.0 controller interface
    "ehci_pci" #  # USB 2.0 controller interface (necessary in initrd? move?)
    "thunderbolt" #
    "usbhid" #    # USB human-interface devices
    "usb_storage" # USB flash drives
    "uas" #       # USB-attached SCSI drives
    "ahci" #      # SATA devices on modern AHCI controllers
    "sd_mod" #    # SCSI, SATA, & PATA (IDE) devices
    "sdhci_pci" # # SD card controller interface
    "rtsx_pci_sdmcc" # Realtek PCIe SD/MMC card host driver
  ];

  environment.systemPackages = [
    pkgs.usbutils
  ];
}
