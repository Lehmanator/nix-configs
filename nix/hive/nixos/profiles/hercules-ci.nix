{ inputs, config, lib, pkgs, ... }: {
  imports = [
    #inputs.self.nixosProfiles.cachix
    inputs.hercules-ci-agent.nixosModules.agent-service
  ];
  services.hercules-ci-agent = {
    enable = true;
    #concurrentTasks = 4;
  };
  sops.secrets.hercules-ci-agent-cluster-join-token = {
    path = "/var/lib/hercules-ci-agent/secrets/cluster-join-token.key";
    owner = "hercules-ci-agent";
    #group = "";
    #mode = "0440";
  };
}
