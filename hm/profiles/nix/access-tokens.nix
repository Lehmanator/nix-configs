{ inputs, config, lib, pkgs, ... }:
{
  #nix.settings.access-tokens = [];
  # !include /run/user/1000/secrets/github-token
  nix.extraOptions = ''
    !include ${config.sops.secrets.github-token.path}
  '';
  sops.secrets.github-token = { };
}
