{ inputs, pkgs, ... }:
{
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #services.flatpak.packages = [{origin="flathub"; appId="so.libdb.gtkcord4";}];
  home.packages = [ pkgs.gtkcord4 ];
}
