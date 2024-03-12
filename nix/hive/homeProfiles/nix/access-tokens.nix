{ config, ... }:
# Notes:
# - Git access tokens are stored in encrypted sops-nix secrets.
# - No easy way to set this via `nix.settings` without string interpolation.
# - String interpolation of sops-nix secrets isn't possible. (can use templates)
# - `nix.conf` option syntax: `access-tokens = "<host>=<token>"`
# - Option `nix.extraOptions`
# This config stores git access tokens in sops-nix secrets.
{
  nix = {
    #settings.access-tokens = [config.sops.secrets.github-token.path];
    extraOptions = ''
      !include ${config.sops.secrets.github-token.path}
    '';
  };

  sops.secrets.github-token = { };
}
