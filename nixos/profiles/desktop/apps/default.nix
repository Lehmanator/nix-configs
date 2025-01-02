{ inputs, config, lib, pkgs, ... }:
{
  imports = [./libreoffice.nix];
  home-manager.sharedModules = [(inputs.self + /hm/profiles/bitwarden.nix)];

  programs.fuse.userAllowOther = true;

  environment.systemPackages = [
    pkgs.bitwarden
    pkgs.fuse3
    pkgs.thunderbird
  ];

}
