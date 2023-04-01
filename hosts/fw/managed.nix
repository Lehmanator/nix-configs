{
  self,
  inputs,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
  ];

  ##
  ## Notes:
  ##
  ## - This file is to be used by `pkgs.nix-software-center`
  ## - Changing settings here may get overwritten
  ## - Permanent settings should be placed elsewhere in config
  ##
  ## To-Dos:
  ##
  ## - [ ] TODO: Configure NixOS to set 'Configuration file' preference in `pkgs.nix-software-center` using gsettings/dconf
  ## - [ ] TODO: Configure NixOS to set 'Flake file'         preference in `pkgs.nix-software-center` using gsettings/dconf
  ##


}
