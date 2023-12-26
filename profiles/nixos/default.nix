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
    inputs.srvos.nixosModules.common
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
    #inputs.nix-data.nixosModules.nix-data
    #inputs.nix-index.nixosModules.nix-index
    #{ programs.nix-index-database.comma.enable = true; }
    #./activate.nix
    ./adb.nix
    ./alias.nix
    #./homed.nix
    ./home-manager.nix
    ./normalize.nix
    #../boot
    ../hardware
    ../locale
    ../network
    ../nix
    ../security
    ../shell
    ../users
    ../sshd.nix
  ]
    #++ lib.optionals (pkgs.system == "x86_64-linux") [ ../boot ../security/apparmor.nix ]
  ;
  appstream.enable = true;
}
