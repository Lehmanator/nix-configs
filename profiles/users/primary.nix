{ self, inputs
, config, lib, pkgs
, user
, host
, ...
}:
{
  imports = [
  ];

  # TODO: Inherit from default
  users.users."${user}" = {
    isNormalUser = true;
    group = "users";
    extraGroups = ["dialout" "wheel"];
  };
}
