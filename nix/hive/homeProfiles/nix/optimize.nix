{ lib, pkgs, ... }: {
  nix = {
    settings.auto-optimise-store = lib.mkDefault true;
    optimise = {
      automatic = lib.mkDefault true; # Store optimizer
      dates = lib.mkDefault [ "03:45" ];
    };
  };
}
