{ config
, lib
, pkgs
, user
, ...
}:
{
  imports = [ ];

  # TODO: Inherit from default
  users.users."${user}" = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "dialout" "wheel" ];
  };
}
