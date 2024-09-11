{ pkgs, config, lib, ... }:
{
  #home.packages = [
  #  pkgs.lemoa #                     # TODO: Package for nixpkgs
  #  pkgs.nur.repos.colinsane.lemoa   # Broken: 8/23
  #];
  services.flatpak.packages = [ "io.github.lemmygtk.lemoa" ];
}
