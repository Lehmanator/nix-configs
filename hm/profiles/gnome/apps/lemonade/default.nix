{ pkgs, config, lib, ... }:
{
  #home.packages = [pkgs.lemonade];  # TODO: Package for nixpkgs
  services.flatpak.packages = [ "flathub:app/ml.mdwalters.Lemonade//stable" ];
}
