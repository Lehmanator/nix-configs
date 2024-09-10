{ inputs, config, lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  services.flatpak = {
    packages = [
      # TODO: GTK themes
      # TODO: QT themes
      # TODO: Runtimes/SDKs?
      { appId = "com.github.GradienceTeam.Gradience"; origin="flathub-beta"; }
    ];
    overrides = {
      global.Context.filesystems = [
        "xdg-config/gtk-4.0:ro"
        "xdg-config/gtk-3.0:ro"
        "xdg-config/gtk-2.0:ro"
      ];
      # TODO: Firefox dirs?
      # TODO: Other plugin dirs?
      "com.github.GradienceTeam.Gradience".Context.filesystems = [
        "xdg-config/gtk-4.0:rw"
        "xdg-config/gtk-3.0:rw"
        "xdg-config/gtk-2.0:rw"
      ];
    };
  };

  # TODO: Package latest Gradience from source
  #home.packages = [pkgs.gradience];
}
