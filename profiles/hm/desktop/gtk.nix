{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
# --- Docs ---
# https://nix-community.github.io/home-manager/options.html#opt-gtk.enable
# https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/named-colors.html
# https://github.com/lassekongo83/adw-colors
# https://gitlab.gnome.org/GNOME/libadwaita (libadwaita source code)
#
# TODO: Handle flatpaks
# - flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.Adw-gtk3-dark
# - sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
# - sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
#
# TODO: Create theme packages:
# - Kvantum: https://github.com/GabePoel/KvLibadwaita
# - Firefox: https://github.com/rafaelmardojai/firefox-gnome-theme
# - Steam: https://github.com/tkashkin/Adwaita-for-Steam
# - VSCode: https://github.com/piousdeer/vscode-adwaita
# - Discord: https://github.com/GeopJr/DNOME
# - Obsidian: https://github.com/birneee/obsidian-adwaita-theme
# - xfwm4: https://github.com/FabianOvrWrt/adw-xfwm4
# - GTK colorschemes: https://github.com/lassekongo83/adw-colors
{
  # TODO: https://gitlab.com/rmnvgr/nightthemeswitcher-gnome-shell-extension
  # TODO: Diff b/w:
  # - gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
  # - dconf write /org/gnome/desktop/interface gtk-theme "'adw-gtk3'"
  #home.packages =
  #  [
  #    pkgs.gnomeExtensions.night-theme-switcher
  #    pkgs.vimPlugins.adwaita-nvim
  #    pkgs.vscode-extensions.piousdeer.adwaita-theme
  #    pkgs.gnome.adwaita-icon-theme
  #    pkgs.adwaita-qt
  #    pkgs.adwaita-qt6
  #    pkgs.adw-gtk3
  #  ]
  #  #++ lib.optionals config.mobile.enable [pkgs.fcitx5-gtk]
  #  ++ lib.optionals pkgs.platforms.isDarwin [pkgs.gtk-mac-integration-gtk2];

  #services.darkman = let
  #  # TODO: Gradience generation
  #  gtk3-mode = mode: let
  #    # TODO: Qt theme?
  #    cursor-theme =
  #      if mode == "dark"
  #      then "Simp1e-Adw"
  #      else "Simp1e-Adw-Dark"; # Reversed for better contrast
  #    gtk3-theme =
  #      if mode == "dark"
  #      then "Adw-gtk3-dark"
  #      else "Adw-gtk3";
  #    gtk-color-palette = ""; # Palette used in color selector
  #    gtk-color-scheme = ""; # List of symbolic names & color equivalents
  #    # Set dconf settings
  #    # TODO: /org/gnome/shell/extensions/nightthemeswitcher/gtk-variants
  #    # - day 'adw-gtk3'
  #    # - night 'adw-gtk3-dark'
  #    # - enabled true
  #    # TODO: /org/gnome/shell/extensions/nightthemeswitcher/shell-variants
  #    # - day ''
  #    # - night 'Custom-Accent-Colors'
  #    # - enabled true
  #    # TODO: /org/gnome/shell/extensions/nightthemeswitcher/cursor-variants
  #    # - day 'Simp1e-Adw-Dark'
  #    # - night 'Simp1e-Adw'
  #    # - enabled true
  #    # TODO: /org/gnome/desktop/interface
  #    # - gtk-color-scheme
  #    # TODO: /org/gnome/desktop/background
  #    # - picture-uri
  #    # - picture-uri-dark
  #    # - primary-color
  #    # - secondary-color
  #  in
  #    with config.xdg; ''
  #      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/cursor-theme "'${cursor-theme}'"
  #      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme "'${gtk3-theme}'"
  #      if [[ -f "${configHome}/gtk-3.0/mode.css" ] && [ -f "${configHome}/gtk-3.0/${mode}.css" ]]; then
  #        unlink "${configHome}/gtk-3.0/mode.css" && \
  #        ln -s "${configHome}/gtk-3.0/gtk-${mode}.css" "${configHome}/gtk-3.0/mode.css"
  #      fi
  #    '';
  #in {
  #lightModeScripts = {
  #  gtk3 = gtk3-mode "light";
  #  gtk4 = ''
  #    ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
  #  '';
  #};
  #
  #darkModeScripts = {
  #  gtk3 = gtk3-mode "dark";
  #  gtk4 = ''
  #    ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
  #  '';
  #};
  #};

  #xdg.configFile = {
  #  "gtk-3.0/gtk-dark.css".text = "";
  #  "gtk-3.0/gtk-light.css".text = "";
  #  "gtk-4.0/gtk-dark.css".text = "";
  #  "gtk-4.0/gtk-light.css".text = "";
  #  "gtk-4.0/gtk.css".text = ''
  #    @import url("mode.css");
  #  '';
  #};

  # Always import `mode.css` (set to either `dark.css` or `light.css` depending on mode)
  # TODO: @import url("common.css");
  # TODO: @import url("wallpaper.css");
  #gtk.gtk3.extraCss = ''
  #  @import url("mode.css");
  #'';

  #-------------------------------------------------------------------------------
  #-------------------------------------------------------------------------------
  #-------------------------------------------------------------------------------
  #-------------------------------------------------------------------------------
  #-------------------------------------------------------------------------------
  #-------------------------------------------------------------------------------

  # Allow fontconfig to discover fonts & configs installed thru `home.packages` & `nix-env`
  #fonts.fontconfig.enable = true;

  #gtk = {
  #  enable = true;
  #  cursorTheme = {
  #    name = "Simp1e-Adw";
  #    package = pkgs.simp1e-cursors;
  #  };
  #  iconTheme = {
  #    name = "MoreWaita"; #"Adwaita";
  #    package = pkgs.nur.repos.federicoschonborn.morewaita;
  #  };
  #
  #  # TODO: Fix setting GTK theme forcing either light or dark mode for GTK2/3, Electron.js, QT apps.
  #  #theme = {
  #  #  name = "Adw-gtk3-dark";
  #  #  package = pkgs.adw-gtk3;
  #  #};
  #
  #  gtk4.extraConfig = {
  #    gtk-theme-name = "Adwaita";
  #    #gtk-application-prefer-dark-theme = 1;
  #  };
  #  gtk3 = {
  #    bookmarks = with config.xdg.userDirs.extraConfig; [
  #      "file:///${XDG_BACKUP_DIR} Backup"
  #      "file:///${XDG_BOOKS_DIR} Books"
  #      "file:///${XDG_CODE_DIR} Code"
  #      "file:///${XDG_NOTES_DIR} Notes"
  #      #"file:///${XDG_AUDIO_DIR} Audio"
  #      "file:///${config.xdg.userDirs.templates} Templates"
  #      "file:///${config.xdg.userDirs.publicShare} Public"
  #      #"google-drive://${email}/${gdrive-hash} Google Drive"
  #      #"google-drive://${email}/${gdrive-shared-hash} Google Drive: Shared"
  #    ];
  #    extraConfig = {
  #      gtk-theme-name = "Adw-gtk3-dark";
  #      #gtk-application-prefer-dark-theme = 1;
  #    };
  #  };
  #  gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc"; # Follow XDG spec
  #};

  #home.packages = [
  #  pkgs.adw-gtk3
  #  pkgs.gnome.adwaita-icon-theme
  #  pkgs.plotinus
  #  #pkgs.nur.repos.ilya-fedin.gtk-layer-background  # Desktop background using GTK wayland layer
  #];
  #home.sessionVariables.GTK3_MODULES = "${pkgs.plotinus}/lib/libplotinus.so";
}
