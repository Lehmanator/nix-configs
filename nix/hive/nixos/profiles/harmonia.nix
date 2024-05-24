{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [inputs.harmonia.nixosModules.harmonia];

  services.harmonia = let
    port = 5000;
  in {
    enable = lib.mkDefault false;
    signKeyPath = lib.mkDefault config.sops.secrets.harmonia-signing-key.path;
    settings = {
      bind = lib.mkDefault "[::]:${port}";
      workers = lib.mkDefault 4;
      max_connection_rate = lib.mkDefault 256;
      priority = lib.mkDefault 50;
    };
  };

  environment.persistence."/nix/persist".files =
    lib.mkIf config.services.harmonia.enable
    [config.sops.secrets.harmonia-signing-key.path];
  networking.firewall.allowedTCPPorts =
    lib.mkIf config.services.harmonia.enable [443 80];

  sops.secrets =
    lib.mkIf config.services.harmonia.enable {harmonia-signing-key = {};};
}
