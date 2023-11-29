{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  security.polkit = {
    enable = true;
    adminIdentities = [
      "unix-group:adm"
      "unix-group:admin"
      #"unix-group:polkitusers"
      "unix-group:wheel"
    ];
    #extraConfig = ''
    #'';
  };
  users.extraGroups.polkituser.members = [ user ];
}
