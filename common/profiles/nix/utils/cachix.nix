{ config, lib, pkgs, ... }:
{
  # CLI for cachix binary caches
  environment.systemPackages = [ pkgs.cachix ];

  # TODO: Cachix env vars?
  # TODO: Nix configuration to use cachix?

  #sops.secrets.cachix-token = {};
}
