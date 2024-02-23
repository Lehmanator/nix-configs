{ inputs
, config
, lib
, pkgs
, ...
}:
{
  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  home.packages = [ pkgs.fractal ]; #pkgs.fractal-next;
  services.flatpak.packages = [
    "flathub:app/org.gnome.Fractal//stable"
    "flathub-beta:app/org.gnome.Fractal//beta"
    "gnome-nightly:app/org.gnome.Fractal.Devel//master"
  ];
}
