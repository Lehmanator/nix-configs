{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  services.cachix-agent = {
    name = "home-manager-${user}";
    enable = true;
    #credentialsFile = "${config.sops.secrets.cachix-agent-token.path}";
  };
  sops.secrets.cachix-agent-token = {
    path = config.services.cachix-agent.credentialsFile;
  };
}
