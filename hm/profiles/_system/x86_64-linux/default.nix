{ inputs
, config
, lib
, pkgs
, osConfig
, user
, ...
}:
{
  imports = [
    ../../arch/x86_64
    ../../platform/linux

    ../../../users/${user}/devices
    ../../../users/${user}/games
  ];

}
