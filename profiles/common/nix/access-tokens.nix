{
  inputs,
  config,
  ...
}:
# Notes:
# - Git access tokens are stored in encrypted sops-nix secrets.
# - No easy way to set this via `nix.settings` without string interpolation.
# - String interpolation of sops-nix secrets isn't possible. (can use templates)
# - `nix.conf` option syntax: `access-tokens = "<host>=<token>"`
# - Option `nix.extraOptions`
# This config stores git access tokens in sops-nix secrets.
#
# TODO:
{
  # Include
  nix.extraOptions = ''
    !include ${config.sops.secrets.github-token.path}
  '';
  #nix.settings.access-tokens = [config.sops.secrets.github-token.path];

  # Write key text to `/etc/nix/access-token-<provider>.key`
  environment = {
    #sessionVariables.NIX_USER_CONF_FILES = "$XDG_CONFIG_HOME/nix/nix.conf.local";
    etc = {
      "nix/access-token-github.key".source =
        config.sops.secrets.github-token.path;
      #"nix/access-token-github-2.key".source =
      #  config.sops.secrets.github-token-2.path;
    };
  };
  sops.secrets.github-token = {};
  #sops.secrets.github-token-2 = {};
}
