{ inputs, config, lib, pkgs , ... }:
{
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
  environment.systemPackages = [
    pkgs.clapper
    pkgs.dino
    pkgs.flare-signal
    pkgs.gnome-network-displays
    pkgs.jellyfin-media-player
    pkgs.megapixels
    pkgs.inkscape
    pkgs.gnome-obfuscate
    pkgs.foliate
    pkgs.warp
  ];

}
