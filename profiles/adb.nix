{ inputs, self
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
  ];

  programs.adb.enable = true;
  users.extraGroups.adbusers.members = [user];

}
