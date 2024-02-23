{ inputs, config, lib, pkgs, ... }:
{
  # TODO: Figure out how to enable per-user encrypted home directories
  # - Compatible with sops-nix?
  # - Compatible with agenix?
  # - Compatible with SSHd?
  # - Compatible with impermanence?
  # - Compatible with LUKS full-disk-encryption?
  # - Compatible with LUKS encrypted system & home root?
  services.homed.enable = true;
}
