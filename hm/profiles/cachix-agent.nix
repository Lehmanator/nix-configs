{
  config,
  lib,
  pkgs,
  ...
}: {
  services.cachix-agent = {
    enable = true;
    #credentialsFile = "${config.sops.secrets.cachix-agent-token.path}";
  };
  sops.secrets.cachix-agent-token = {
    path = config.services.cachix-agent.credentialsFile;
  };
}
