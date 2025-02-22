{
  inputs,
  config,
  lib,
  ...
}: let
  # Default = 5000
  port = 5002;
in {
  imports = [inputs.harmonia.nixosModules.harmonia];

  services.harmonia = {
    enable = true;
    signKeyPath = lib.mkDefault config.sops.secrets.harmonia-signing-key.path;
    settings = {
      bind = lib.mkDefault "[::]:${port}";
      workers = lib.mkDefault 4;
      max_connection_rate = lib.mkDefault 256;
      priority = lib.mkDefault 50;
    };
  };

  networking.firewall.allowedTCPPorts = lib.mkIf config.services.harmonia.enable [port 443 80];

  # Harmonia signing key to sign store paths
  sops.secrets = lib.mkIf config.services.harmonia.enable {
    harmonia-signing-key = {};
  };
}
