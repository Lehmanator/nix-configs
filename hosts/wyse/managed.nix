{
  self,
  inputs,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
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
  environment.systemPackages = [
    pkgs.clapper
    pkgs.dino
    pkgs.flare-signal
    pkgs.gnome-network-displays
    #pkgs.pitivi                   # Broken dep: python310Packages.librosa-0.10.0 (2023-08-14)
    pkgs.jellyfin-media-player
    #pkgs.teams-for-linux # Outdated dep: electron_24
    #pkgs.paper-note  (abandoned)
    pkgs.megapixels
    pkgs.inkscape
    pkgs.gnome-obfuscate
    pkgs.foliate
    pkgs.warp
  ];


}
