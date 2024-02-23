{ inputs, config, lib, pkgs, ... }:
{
  home.packages = [ pkgs.asterisk-ldap ]; # Software implementation of a telephone private branch exchange (PBX)
}
