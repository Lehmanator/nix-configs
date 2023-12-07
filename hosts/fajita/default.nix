{ inputs
, user
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #(import (inputs.mobile-nixos + "/lib/configuation.nix") { device = "oneplus-fajita"; })

    # System configuration
    ./configuration.nix
    ./mobile.nix

    # Configuration related to hardware
    #./hardware-configuration.nix

    # Uses some stuff from SnowflakeOS
    #./snowflake.nix

    # Handles hardware peripherals for external & internal displays
    #./displays.nix

    # Include configuration managed by apps:
    # - nixos-conf-editor
    # - nix-software-center
    #./managed.nix

    ./profiles.nix
  ];

  nixpkgs.config.allow-unfree = true;
}
