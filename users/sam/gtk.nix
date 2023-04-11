{ config, lib, pkgs, ... }: {
  imports = [];

  # https://nix-community.github.io/home-manager/options.html#opt-gtk.enable

  # Allow fontconfig to discover fonts & configs installed thru `home.packages` & `nix-env`
  fonts.fontconfig.enable = true;

  # --- GTK ---
  gtk.enable = true;
  gtk.iconTheme.name = "Adwaita";
  gtk.iconTheme.package = pkgs.gnome.adwaita-icon-theme;

  # TODO: Fix setting GTK theme forcing either light or dark mode for GTK2/3, Electron.js, QT apps.
  #gtk.theme.name = "Adw-gtk3";
  #gtk.theme.package = pkgs.adw-gtk3;

  home.packages = [
    pkgs.adw-gtk3
  ];
}
