{ config, lib, pkgs
, ...
}:
{
  imports = [
    #./activedirectory.nix
    ./redis.nix
    ./samba.nix
  ];
  home.packages = [ pkgs.nmap pkgs.dig ];
}
