{ inputs
, self
, config
, lib
, pkgs
, system ? "x86_64-linux"
, ...
}:
{
  imports = [
    #../os/android
    #../os/postmarketos.nix
  ];

  home.packages = [
  ];

  # TODO: Install Bottles with OnePlus MDM tool
  # TODO: Generic flasher scripts for OnePlus devices
}
