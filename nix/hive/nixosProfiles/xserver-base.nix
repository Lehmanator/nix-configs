{ inputs, config, lib, pkgs, user, ... }: {
  services.xserver.enable = true;
  users.users.${user}.extraGroups = [ "video" ];
}
