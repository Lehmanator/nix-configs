{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.asterisk-ldap   # Software implementation of a telephone private branch exchange (PBX)
  ];

}
