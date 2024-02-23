{ pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ./profiles.nix
    #./displays.nix
    #./hardware-configuration.nix # Include the results of the hardware scan.
    #./snowflake.nix # Include SnowflakeOS config
  ];
}
