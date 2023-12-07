{ inputs
, config
, lib
, pkgs
, osConfig
, ...
}:
# https://nix-community.github.io/home-manager/options.html#opt-gtk.enable
{
  imports = [ ];

  # Allow fontconfig to discover fonts & configs installed thru `home.packages` & `nix-env`
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Simp1e-Adw";
      package = pkgs.simp1e-cursors;
    };
    iconTheme = {
      name = "MoreWaita"; #"Adwaita";
      package = pkgs.nur.repos.federicoschonborn.morewaita;
    };

    # TODO: Fix setting GTK theme forcing either light or dark mode for GTK2/3, Electron.js, QT apps.
    #theme = {
    #  name = "Adw-gtk3-dark";
    #  package = pkgs.adw-gtk3;
    #};

    gtk4.extraConfig = {
      gtk-theme-name = "Adwaita";
      #gtk-application-prefer-dark-theme = 1;
    };
    gtk3 = {
      bookmarks = with config.xdg.userDirs.extraConfig; [
        "file:///${XDG_BACKUP_DIR}"
        "file:///${XDG_BOOKS_DIR}"
        "file:///${XDG_CODE_DIR}"
        "file:///${XDG_NOTES_DIR}"
        #"file:///${XDG_AUDIO_DIR}"
        "file:///${config.xdg.userDirs.templates}"
        "file:///${config.xdg.userDirs.publicShare}"
        #"google-drive://${email}/${gdrive-hash} Google Drive"
        #"google-drive://${email}/${gdrive-shared-hash} Google Drive: Shared"
      ];
      extraConfig = {
        gtk-theme-name = "Adw-gtk3-dark";
        #gtk-application-prefer-dark-theme = 1;
      };
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
