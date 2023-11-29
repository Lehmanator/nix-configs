{ inputs, config, lib, pkgs, ... }:
{
  #nix.settings.access-tokens = [];
  #!include ${config.sops.secrets.github-token.path}
  nix.extraOptions = ''
    !include /run/user/1000/secrets/github-token
  '';
  sops.secrets.github-token = { };
}
