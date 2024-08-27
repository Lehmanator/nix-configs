{ lib , pkgs , config , ... }: {
  #imports = [inputs.declarative-flatpak.homeManagerModules.default ];
  #services.flatpak.packages = ["flathub:app///stable"];

  home.packages = [
    #pkgs.gnomeExtensions.gsconnect
    #pkgs.gnomeExtensions.valent
    #pkgs.valent
    #pkgs.valent-unstable
  ];
}
