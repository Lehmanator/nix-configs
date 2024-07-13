{ pkgs, ... }: {

  # TODO: Repo forked, this version unmaintained, update to new repo.
  # Old: https://github.com/avanisubbiah/material-you-theme
  # New: https://github.com/FrancescoCaracciolo/material-you-colors
  programs.gnome-shell.extensions = [{
    package = pkgs.gnomeExtensions.material-you-color-theming;
  }];

  # Make deps available.
  # TODO: Check if working properly
  home.packages = [ pkgs.pywal ];

  # TODO: Dconf settings

  # https://gdm-settings.github.io/
  # https://github.com/gdm-settings/gdm-settings
  services.flatpak.packages = [
    { appId = "io.github.realmazharhussain.GdmSettings"; }
  ];
}
