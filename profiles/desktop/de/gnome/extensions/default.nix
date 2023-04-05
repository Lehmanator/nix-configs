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
let
  # TODO: Use dconf2nix to create Nix config files for each GNOME extension & place in this dir
in
{
  imports = [
    #./animation.nix
    ./clock.nix
    ./desktop.nix
    ./gestures.nix
    #./quicksettings.nix
    ./search.nix
  ];

  environment.systemPackages = (with pkgs; [
    gnome-extension-manager
  ]) ++ (with pkgs.gnomeExtensions; [
    # Display app indicator icons in the top panel
    # TODO: Determine best app indicator extension (DING, base, GTK4-ng, ...)
    appindicator
    blur-my-shell            # Blur GNOME UI elements
    burn-my-windows          # Change window open/close animations
    ddterm                   # Dropdown terminal
    favourites-in-appgrid    # Keep favorites in the app grid
    forge                    # Tile, tab, & stack windows extension like pop-shell
    gsconnect                # Connect your phone
    live-captions-assistant  # Better desktop integration w/ Live Captions app
    material-you-color-theming # Material You palettes from wallpaper applied to libadwaita
    pano                     # Clipboard manager
    quick-settings-tweaker   # QS config. Notifs: clock -> QS

    # Overlay to show keyboard shortcuts
    shortcuts

    # Snow effect on your desktop
    #snowy

    # ??
    #surf            # <43

    # Show performance/load/sensor info in panel
    vitals
  ]);

  # GUI to configure application settings
  programs.dconf.enable = true;

  # --- Native Messaging Host Connectors ---
  # Firefox: GSConnect
  programs.firefox.nativeMessagingHosts.gsconnect = true;

  # GNOME Extensions connector
  services.gnome.gnome-browser-connector.enable = true;
}
