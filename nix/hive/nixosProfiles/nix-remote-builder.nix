{ inputs, config, lib, pkgs, ... }:
{
  imports = [ inputs.srvos.nixosModules.roles-nix-remote-builder ];

  roles.nix-remote-builder = {
    schedulerPublicKeys = [ ]; # SSH Pubkeys of central build scheduler.
  };
}
