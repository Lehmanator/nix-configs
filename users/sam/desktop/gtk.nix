{ config, lib, pkgs, ... }: {
  imports = [ ];

  # https://nix-community.github.io/home-manager/options.html#opt-gtk.enable

  # Allow fontconfig to discover fonts & configs installed thru `home.packages` & `nix-env`
  fonts.fontconfig.enable = true;

  # --- GTK ---
  gtk = {
    enable = true;
    cursorTheme.name = "Simp1e-Adw";
    cursorTheme.package = pkgs.simp1e-cursors;
    iconTheme.name = "MoreWaita"; #"Adwaita";
    iconTheme.package = pkgs.nur.repos.federicoschonborn.morewaita;

    # TODO: Fix setting GTK theme forcing either light or dark mode for GTK2/3, Electron.js, QT apps.
    #theme.name = "Adw-gtk3-dark";
    #theme.package = pkgs.adw-gtk3;
    gtk4.extraConfig = {
      gtk-theme-name = "Adwaita";
      #gtk-application-prefer-dark-theme = 1;
    };
    gtk3.extraConfig = {
      gtk-theme-name = "Adw-gtk3-dark";
      #gtk-application-prefer-dark-theme = 1;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc"; # Follow XDG spec
  };

  home.packages = [
    pkgs.adw-gtk3
    pkgs.gnome.adwaita-icon-theme
    pkgs.plotinus
    #pkgs.nur.repos.ilya-fedin.gtk-layer-background  # Desktop background using GTK wayland layer
  ];
  #home.sessionVariables.GTK3_MODULES = "${pkgs.plotinus}/lib/libplotinus.so";
}
