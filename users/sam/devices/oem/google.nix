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
    #../os/android/13.nix
    #../os/android/14.nix
    #../os/android/aosp.nix
    #../os/android/calyxos.nix
    #../os/android/grapheneos.nix
    #../os/postmarketos.nix
  ];

  home.packages = [
  ];

  # TODO: Install Bottles with OnePlus MDM tool
  # TODO: Generic flasher scripts for OnePlus devices
}
