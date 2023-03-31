{
  self,
  system,
  userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  programs.adb.enable = true;

  users.extraGroups.adbusers = { name = "adbusers"; members = [ "sam" ]; }; 
}
