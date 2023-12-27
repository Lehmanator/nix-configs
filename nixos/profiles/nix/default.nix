{ config, lib, pkgs, ... }:
{
  imports = [
    ./activation-script.nix
    ./shell.nix

    #../../common/nix
    #../../linux/nix

    #./ssh-serve-store.nix
  ];

  #nix = { };

}
