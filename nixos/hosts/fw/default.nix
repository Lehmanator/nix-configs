{ inputs, ... }:
{
  imports = [
    ./configuration.nix # System configuration
    #./hardware-configuration.nix # Configuration related to hardware
    #./snowflake.nix # Uses some stuff from SnowflakeOS
    ./displays.nix # Handles hardware peripherals for external & internal displays
    ./managed.nix # Include app-managed config: nixos-conf-editor & nix-software-center
    ./profiles.nix # Include imported profiles
  ];

  environment.etc.machine-id.text = "aa38a832d16e436d8aab8bb0550d4810";
}
