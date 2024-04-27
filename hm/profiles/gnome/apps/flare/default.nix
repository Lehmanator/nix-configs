{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = [ pkgs.flare-signal ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = [
  #  "flathub:app/de.schmidhuberj.Flare//stable"
  #  #"flathub-beta:app/de.schmidhuberj.Flare//beta"
  #];

  # TODO: Signal protocol string handler?
}
