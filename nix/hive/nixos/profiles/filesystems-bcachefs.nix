{ config, lib, pkgs, ... }: {

  boot.initrd = {
    services.bcache.enable = true;
    supportedFilesystems = [ "bcachefs" ];
  };

}
