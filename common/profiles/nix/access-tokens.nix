{ inputs, config, ... }:
{
  nix.extraOptions = ''
    !include ${config.sops.secrets.github-token.path}
  '';
  sops.secrets.github-token = { };
}
