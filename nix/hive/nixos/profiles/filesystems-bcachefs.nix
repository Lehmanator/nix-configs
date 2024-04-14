{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [
  ];

  # --- bcachefs ---
  boot.initrd = {
    services.bcache.enable = true;
    supportedFilesystems = [ "bcachefs" ];
  };

}
