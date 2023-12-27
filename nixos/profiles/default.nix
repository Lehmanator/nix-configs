{ inputs
, config
, lib
, pkgs
, user
, ...
}:
# TODO: Move all config that isn't NixOS-specific stuff to common file
{
  imports = [
    ../../common/profiles

    ./modules

    ./hardware
    ./locale
    ./network
    ./nix
    ./security
    ./shell
    ./users

    ./adb.nix
    ./normalize.nix
    ./sshd.nix

    #inputs.srvos.nixosModules.common
    #inputs.srvos.nixosModules.mixins-nix-experimental
    #inputs.srvos.nixosModules.mixins-trusted-nix-caches
    #
    #inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
    #./nix/activation-script.nix
    #./boot
    #./home-manager.nix
    #./users/homed.nix
  ];

  appstream.enable = true;
}
