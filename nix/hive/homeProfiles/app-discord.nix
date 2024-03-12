{ inputs
, config
, lib
, pkgs
, # Choose package format preference
  prefer-flatpak ? false
, ...
}: {
  home.packages = lib.mkIf (prefer-flatpak == false) [
    # https://github.com/uowuo/abaddon
    #pkgs.abaddon # C++ Discord Client

    #pkgs.armcord # Lightweight Discord desktop client

    # https://betterdiscord.app
    # TODO: Package BetterDiscord plugins
    #pkgs.betterdiscordctl # Util for managing BetterDiscord
    #pkgs.betterdiscord-installer # Installer for BetterDiscord

    pkgs.discocss # Discord css-injectory
    pkgs.discordo # Terminal Discord client

    # TODO: Package plugins
    # TODO: Package themes
    # TODO: Module to configure plugins themes in ~/.config/dorion/{plugins/plugin.js,themes/theme.css}
    #pkgs.dorion # Tauri client for Discord

    pkgs.pidginPackages.purple-discord
    #pkgs.vesktop # Linux desktop client for Discord w/ Vencord built-in
    #pkgs.webcord # Electron client for Discord & SpaceBar w/o Discord API.

    # TODO: Move to homeProfiles.roles-creator-streaming
  ] ++ lib.optionals config.gtk.enable [
    # Native GTK Discord Client
    pkgs.gtkcord4
  ];

  # TODO: Download WebExtensions to config.xdg.dataHome/WebCord/Extensions/Chrome/{name}/*.crx
  # TODO: Set permissions to read config files for GTK theme
  services.flatpak.packages = lib.mkIf prefer-flatpak [
    "flathub:app/xyz.armcord.ArmCord//stable"
    #"flathub:app/.Dorion//stable"
    #"flathub:app/.Vesktop//stable"
    #"flathub:app/.Webcord//stable"
  ] ++ lib.optionals config.gtk.enable
    [ "flathub:app/so.libdb.gtkcord4//stable" ];

  # TODO: Symlink to flatpak configs or enable permission: xdg-config:ro
  xdg =
    let
      gtk-theme-text = ''
        @import url("${inputs.self.packages.theme-gtk-dnome}/DNOME.css");
      '';
    in
    {
      configFile = lib.mkIf config.gtk.enable {
        "discocss/gtk-light.css".text = gtk-theme-text;
        "discocss/gtk-dark.css".text = gtk-theme-text;
        "discocss/gtk.css".text = gtk-theme-text;
        "discocss/custom.css".text = gtk-theme-text;
        "dorion/themes/gtk.css".text = gtk-theme-text;
        #"discocss/custom.css".text = ''
        #  @import url("./gtk.css");
        #'';
      };
      dataFile =
        lib.mkIf config.gtk.enable { "abaddon/res/css".text = gtk-theme-text; };
    };
}
