{ config, lib, pkgs, ... }: {
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.concatStringsSep " " [
      "--max-freed 100G"
      "--max-jobs 1"
      "--cores 1"
      "--timeout 30"
      "--delete-older-than 30d"
    ];
  };
}
