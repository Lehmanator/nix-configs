{ inputs, config, lib, pkgs, ... }:
{
  #nix.settings.access-tokens = [];
  nix.extraOptions = ''
    !include ${config.sops.secrets.github-token.path}
  '';
  sops.secrets.github-token = { };
}
