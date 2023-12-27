{ inputs, pkgs, ... }:
{

  home.packages = [ pkgs.gtkcord4 ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = ["flathub:app/so.libdb.gtkcord4//stable"];

}
