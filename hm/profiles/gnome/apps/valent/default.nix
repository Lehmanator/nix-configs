{ lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
  #services.flatpak.packages = ["flathub:app///stable"];
  home.packages = [
    #pkgs.gnomeExtensions.gsconnect
    #pkgs.gnomeExtensions.valent
    #pkgs.valent
    #pkgs.valent-unstable
  ];
}
