{
  self,
  system,
  inputs,
  userPrimary,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  services.xserver.enable = true;

  users.users."sam".extraGroups = [ "video" ];
}
