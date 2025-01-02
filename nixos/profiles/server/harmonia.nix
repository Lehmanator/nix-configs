{ inputs, config, lib, pkgs, ... }:
let
  inherit (lib) mkDefault mkIf;
  port = 5000;
in
{
  imports = [ inputs.harmonia.nixosModules.harmonia ];

  services.harmonia = {
    enable                = mkDefault false;
    signKeyPath           = mkDefault config.sops.secrets.harmonia-signing-key.path;
    settings = {
      bind                = mkDefault "[::]:${port}";
      workers             = mkDefault 4;
      max_connection_rate = mkDefault 256;
      priority            = mkDefault 50;
    };
  };

  # Persist data for Harmonia
  environment.persistence."/nix/persist".files = mkIf config.services.harmonia.enable [ config.sops.secrets.harmonia-signing-key.path ];

  # Allow through firewall
  networking.firewall.allowedTCPPorts = mkIf config.services.harmonia.enable [port 443 80 ];

  # Harmonia signing key to sign store paths
  sops.secrets = mkIf config.services.harmonia.enable {
    harmonia-signing-key = { };
  };
}
