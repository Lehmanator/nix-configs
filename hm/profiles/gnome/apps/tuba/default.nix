{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = [ pkgs.tuba ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = [
  #  "flathub:app/dev.geopjr.Tuba//stable"
  #];

  # TODO: Protocol string handler for Mastodon?

}
