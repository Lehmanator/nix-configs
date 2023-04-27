# GNOME Shell Extensions
{
  self,
  system,
  inputs,
  host, repo, network,
  userPrimary,
  config, lib, pkgs,
  ...
}:
{
  # TODO: Use dconf2nix to create Nix config files for each GNOME extension & place in this dir

  imports = [
    #./animation.nix
    ./appearance.nix
    #./clock.nix
    ./desktop.nix
    ./gestures.nix
    ./gsconnect.nix
    ./quicksettings.nix
    ./search.nix
  ];

  environment.systemPackages = (with pkgs; [
    gnome-extension-manager

    easyeffects
    #gnomeExtensions.easyeffects-preset-selector  # environment.systemPackages = [pkgs.easyeffects];
  ]) ++ (with pkgs.gnomeExtensions; [
    # Display app indicator icons in the top panel
    # TODO: Determine best app indicator extension (DING, base, GTK4-ng, ...)
    dash-to-panel                 # Taskbar w/ lots of features
    #dash2dock-lite               # Dock w/ animations, dynamic icons, symbolic icons, & more
    ddterm                        # Dropdown terminal
    #pin-app-folders-to-dash       # Pin app folders to dash like app icons (overview)
    #favourites-in-appgrid        # Keep favorites in the app grid (overview-feature-pack)
    forge                         # Tile, tab, & stack windows extension like pop-shell
    #live-captions-assistant       # Better desktop integration w/ Live Captions app
    #notification-banner-position # Move where notifications show (just-perfection)
    power-profile-switcher        # Auto switch power profiles based on charge status & battery level
    #surf                         # <43

    # --- Integrations ------------
    # https://github.com/harshadgavali/searchprovider-for-browser-tabs
    #gsconnect                     # Connect your phone
    #notifications-to-file        # Append notifications to a file in $HOME/.notifications
    pano                          # Clipboard manager
    #shortcuts                     # Overlay to show keyboard shortcuts
    #window-calls-extended         # D-Bus call for getting windows & their properties

    # --- Indicators & Menus ------
    #appindicator
    media-controls                # Display info & controls for playing media
    #top-bar-organizer             # Reorder items in the top bar
    #vitals                        # Show performance/load/sensor info in panel
    weather-or-not                # Display clickable weather status panel button next to clock

    # --- Workspaces & Overview ---
    #ofp-overview-feature-pack     # Lots of useful features for overview & dash, incl. window search provider
    #worksets                      # Custom workspaces each w/ favorites, wallpaper, & more
    #workspace-scroll             # Scroll on top panel to switch workspaces (<43)

    # --- Collections -------------
    #just-perfection               # Lots of tweaks

  ]);

  # GUI to configure application settings
  programs.dconf.enable = true;

  # --- Native Messaging Host Connectors ---
  # Firefox: GSConnect
  programs.firefox.nativeMessagingHosts.gsconnect = true;

  # GNOME Extensions connector
  services.gnome.gnome-browser-connector.enable = true;
}
