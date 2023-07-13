{ inputs, self
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 100;
  };
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  #boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
}
