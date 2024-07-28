{ config, lib, pkgs, ... }: {
  # https://docs.cachix.org/deploy/deploying-to-agents
  # https://docs.cachix.org/deploy/reference
  # https://github.com/cachix/cachix-deploy-flake             @ Functions to help manage Cachix Deploy
  # https://github.com/cachix/cachix-deploy-hetzner-dedicated # Bootstrap Hetzner machines w/ one cmd & deploy w/ GitHub Actions
  # https://github.com/cachix/cachix-ci-agents                # Self-hosted GitHub Runners
  services = {
    cachix-agent = rec {
      enable = true;
      credentialsFile = lib.mkIf enable config.sops.secrets.cachix-agent-token.path;

      # name = config.networking.hostName; # config.networking.fqdn;
      # host = null;
      # package = pkgs.cachix;
      # verbose = false;
      # profile = "system";
    };

    cachix-watch-store = rec {
      enable = false;
      cachixTokenFile = lib.mkIf enable config.sops.secrets.cachix-agent-token.path;
      signingKeyFile  = lib.mkIf enable config.sops.secrets.cachix-signing-key.path;

      # cacheName = "";
      # compressionLevel = null; # 0-16;
      # host = null;
      # jobs = null; # <num-threads>
      # package = pkgs.cachix;
      # verbose = false;
    };
  };

  sops.secrets = {
    cachix-agent-token    = lib.mkIf config.services.cachix-agent.enable { path = "/etc/cachix-agent.token"; };
    cachix-activate-token = lib.mkIf config.services.cachix-agent.enable {};
    cachix-signing-key    = lib.mkIf config.services.cachix-watch-store.enable {};
  };

  # environment.sessionVariables.CACHIX_ACTIVATE_TOKEN = "";

  
  # https://nix.dev/guides/recipes/post-build-hook
  # https://nix.dev/manual/nix/2.22/command-ref/conf-file#conf-post-build-hook
  # https://blog.cachix.org/posts/2024-01-12-cachix-v1-7/
  # TODO: Write systemd unit?
  # nix.settings = {
  #   pre-build-hook = (pkgs.writeShellApplication {name="cachix-pre-build-hook.sh"; text="";});
  #   post-build-hook = (pkgs.writeShellApplication {
  #     name = "cachix-push-build-hook.sh";
  #     text = ''
  #       ${lib.getExe pkgs.cachix} daemon push $OUT_PATHS
  #     '';
  #   });
  # };

}
