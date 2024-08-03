{ config, lib, pkgs, user, ... }:
{
  # TODO: Inherit from default
  users.users."${user}" = {
    isNormalUser = true;

    # TODO: Migrate to more standard "username:username"
    # TODO: Create new "users" group & add primary user.
    group = "users";
    extraGroups = [ "dialout" "wheel" "sshd" ];
  };
}
