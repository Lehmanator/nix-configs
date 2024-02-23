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
    ./configuration.nix #         # System configuration
    #./hardware-configuration.nix # Configuration related to hardware
    #./mobile.nix                 # Mobile configuration
    #./snowflake.nix #            # Uses some stuff from SnowflakeOS
    #./displays.nix #             # Handles hardware peripherals for external & internal displays
    #./managed.nix #              # Include app-managed config: nixos-conf-editor & nix-software-center
    ./profiles.nix #              # Include profiles
  ];
  networking.hostName = "fajita";
  system.stateVersion = "23.11";
}
