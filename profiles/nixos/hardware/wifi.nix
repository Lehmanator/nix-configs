{lib, ...}: {
  hardware.wirelessRegulatoryDatabase = lib.mkDefault true;
  networking.enableB43Firmware = lib.mkDefault true;
}
