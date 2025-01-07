{ config, lib, pkgs, ... }:
{
  boot.bootspec = {
    # Write bootspec docs for each build.
    enable = true; #mkDefault true;

    # Validate bootspec documents upon each build.
    # - Note: introduces build-time Golang dep Cuelang.
    # - Warn: Make certain bootspec docs are correct.
    enableValidation = true; #mkDefault true;

    # extensions = {}; 
  };

  environment.systemPackages = [pkgs.bootspec];
}
