{
  self, inputs,
  system, userPrimary,
  config, lib, pkgs,
  ...
}:
{
  security.polkit.enable = true;

  security.polkit.adminIdentities = [
    "unix-group:adm"
    "unix-group:admin"
    #"unix-group:polkitusers"
    "unix-group:wheel"
  ];

  #security.polkit.extraConfig = ''
  #'';

  users.extraGroups.polkituser = { name = "polkituser"; members = [ "sam" ]; };
}
