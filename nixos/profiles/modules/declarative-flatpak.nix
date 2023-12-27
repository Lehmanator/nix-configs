{ inputs, config, lib, pkgs, ... }:
{
  imports = [ inputs.declarative-flatpak.nixosModules.declarative-flatpak ];
  #services.flatpak = {
  #};

  home-manager.sharedModules = [ inputs.declarative-flatpak.homeManagerModules.declarative-flatpak ];
}
