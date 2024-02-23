{ pkgs, config, lib, ... }:
{
  #home.packages = [pkgs.paper-plane];  # TODO: Package for nixpkgs
  services.flatpak.packages = [ "flathub-beta:app/app.drey.PaperPlane//beta" ];
}
