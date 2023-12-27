{ inputs
, config
, lib
, pkgs
, ...
}:
{
  #imports = [inputs.declarative-flatpak.homeManagerModules.default];

  # TODO: Package latest Gradience from source
  #home.packages = [pkgs.gradience];

  services.flatpak = {
    packages = [
      # TODO: GTK themes
      # TODO: QT themes
      # TODO: Runtimes/SDKs?
      "flathub-beta:app/com.github.GradienceTeam.Gradience//beta"
    ];
    overrides = {
      global.filesystems = [
        "xdg-config/gtk-4.0:ro"
        "xdg-config/gtk-3.0:ro"
        "xdg-config/gtk-2.0:ro"
      ];
      # TODO: Firefox dirs?
      # TODO: Other plugin dirs?
      "com.github.GradienceTeam.Gradience".filesystems = [
        "xdg-config/gtk-4.0:rw"
        "xdg-config/gtk-3.0:rw"
        "xdg-config/gtk-2.0:rw"
      ];
    };
  };

}
