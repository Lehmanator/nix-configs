{ self, inputs, config, lib, pkgs, ... }: {
  imports = [];
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];
}

