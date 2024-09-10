{ pkgs, config, lib, ... }:
{
  #home.packages = [pkgs.paper-plane];  # TODO: Package for nixpkgs
  services.flatpak.packages = [{origin="flathub-beta"; appId="app.drey.PaperPlane";}];
}
