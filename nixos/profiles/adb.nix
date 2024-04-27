{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  programs.adb.enable = true;
  users.extraGroups.adbusers.members = [ user ];
}
