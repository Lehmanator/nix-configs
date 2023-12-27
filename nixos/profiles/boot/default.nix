{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [
    #./secureboot.nix
    ./systemd.nix
    ./splash.nix
  ];

  boot.loader.timeout = lib.mkDefault 6; # Seconds until bootloader boots default menu item. Use `null` if loader should wait indefinitely.

}
