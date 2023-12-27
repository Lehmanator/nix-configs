{ inputs, config, appId, ... }:
{
  imports = [ inputs.srvos.nixosModules.roles-github-actions-runner ];

  # https://nix-community.github.io/srvos/github_actions_runner/#authentication
  roles.github-actions-runner = {
    url = "https://github.com/Lehmanator";
    count = 4;
    name = "github-runner";
    githubApp = {
      id = appId; #"<YOUR_GENERATED_APP_ID>";
      login = "Lehmanator";
      privateKeyFile = config.sops.secrets.github-app-runner-privkey.path;
    };
    cachix.cacheName = "Lehmanator";
    cachix.tokenFile = config.sops.secrets.cachix-token.path;
  };

  sops.secrets = {
    github-app-runner-privkey = { };
    cachix-token = { };
  };

}
