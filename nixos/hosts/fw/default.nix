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

  # https://github.com/nixvital/fprint-clear
  # https://github.com/ssddq/fw-ectool
  # https://github.com/mdvmeijer/fw-fanctrl-nix
  # https://github.com/DHowett/FrameworkHacksPkg
  # https://github.com/taotien/framework_toolbox
  # https://github.com/DHowett/framework-ec
  # https://github.com/morpheus636/awesome-framework
}
