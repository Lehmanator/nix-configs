{
  config,
  lib,
  pkgs,
  ...
}: {
  #imports = [ ./cachix.nix ];
  services.hercules-ci-agent = {enable = true;};
  sops.secrets.hercules-ci-agent-cluster-join-token = {
    path = "/var/lib/hercules-ci-agent/secrets/cluster-join-token.key";
    owner = "hercules-ci-agent";
    #group = "";
    #mode = "0440";
  };
}
