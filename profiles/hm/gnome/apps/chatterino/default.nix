{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # TODO: Move to `../../../apps/chatterino`
  home.packages = [ pkgs.chatterino2 ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = [
  #  "flathub:app/com.chatterino.chatterino//stable"
  #  "flathub-beta:app/com.chatterino.chatterino//beta"
  #  "flathub:app/com.chatterino.chatterino//nightly"
  #];

}
