{ inputs, self
, user
, config, lib, pkgs
, ...
}:
{
  imports = [

    # System configuration
    ./configuration.nix

    # Configuration related to hardware
    ./hardware-configuration.nix

    # Uses some stuff from SnowflakeOS
    ./snowflake.nix

    # Handles hardware peripherals for external & internal displays
    ./displays.nix

    # Include configuration managed by apps:
    # - nixos-conf-editor
    # - nix-software-center
    ./managed.nix

  ];

}
