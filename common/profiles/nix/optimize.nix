{ config, lib, pkgs, ... }:
{
  nix = {
    optimise = {
      automatic = true; # Store optimizer
      dates = [ "03:45" ];
    };
    settings = {
      auto-optimise-store = true; # Dedup
      min-free = 128000000;
      max-free = 1000000000;
      keep-derivations = true;
      keep-env-derivations = false;
      keep-going = lib.mkDefault false;
      keep-outputs = lib.mkDefault true;
      preallocate-contents = lib.mkDefault true;
    };
  };
}
