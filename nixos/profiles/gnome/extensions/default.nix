{ config, lib, pkgs, ... }:
{
  # GNOME Shell Extensions default config
  # TODO: Use dconf2nix to create Nix config files for each GNOME extension & place in this dir
  imports = [
    # ./animation.nix
    ./appearance.nix
    ./clock.nix
    ./ddterm.nix
    ./desktop.nix
    ./forge.nix
    ./gsconnect.nix
    ./quicksettings.nix
    ./search.nix
    ./pano
    ./vitals.nix
  ];

  # TODO: Determine best app indicator extension (DING, base, GTK4-ng, ...)
  environment.systemPackages = [
    pkgs.gnome-extension-manager
    #pkgs.gnomeExtensions.dash2dock-lite #              # Dock w/ animations, dynamic icons, symbolic icons, & more
    pkgs.gnomeExtensions.dash-to-panel #                # Taskbar w/ lots of features
    #pkgs.gnomeExtensions.pin-app-folders-to-dash #     # Pin app folders to dash like app icons (overview)
    #pkgs.gnomeExtensions.favourites-in-appgrid #       # Keep favorites in the app grid (overview-feature-pack)
    pkgs.gnomeExtensions.live-captions-assistant #      # Better desktop integration w/ Live Captions app
    #pkgs.gnomeExtensions.notification-banner-position ## Move where notifications show (just-perfection)
    pkgs.gnomeExtensions.power-profile-switcher #       # Auto switch power profiles based on charge/battery status
    #pkgs.gnomeExtensions.surf #                        # <43

    # --- Integrations ------------
    # https://github.com/harshadgavali/searchprovider-for-browser-tabs
    pkgs.gnomeExtensions.shortcuts #                    # Overlay to show keyboard shortcuts
    #pkgs.gnomeExtensions.window-calls-extended #       # D-Bus call for getting windows & their properties

    # --- Indicators & Menus ------
    pkgs.gnomeExtensions.appindicator #                 # Display app indicator icons in the top panel
    pkgs.gnomeExtensions.media-controls #               # Display info & controls for playing media
    #pkgs.gnomeExtensions.top-bar-organizer #           # Reorder items in the top bar

    # --- Workspaces & Overview ---
    #pkgs.gnomeExtensions.ofp-overview-feature-pack #   # Lots of useful features for overview & dash, incl. window search provider
    #pkgs.gnomeExtensions.worksets #                    # Custom workspaces each w/ favorites, wallpaper, & more
    #pkgs.gnomeExtensions.workspace-scroll #            # Scroll on top panel to switch workspaces (<43)

    # --- Collections -------------
    pkgs.gnomeExtensions.just-perfection #              # Lots of tweaks

  ];

  # GNOME Extensions browser connector
  services.gnome.gnome-browser-connector.enable = true;

}
