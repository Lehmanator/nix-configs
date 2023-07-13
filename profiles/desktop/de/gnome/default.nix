# See all GNOME packages:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ self, inputs
, config, lib, pkgs
, options
, userPrimary ? "sam"
, ...
}:
#lib.attrsets.recursiveUpdate
{
  imports = [
    #./common.nix
    #../../autologin.nix { user = userPrimary; }
    ../../gtk.nix
    ../../wayland.nix
    #../../xwayland.nix
    ./apps
    ./extensions
  ];

  # --- Packages -----------------------------------------------------
  programs.dconf.enable = true;
  programs.evince.enable = true;
  #programs.evolution.enable = true;
  #programs.evolution.plugins = [ pkgs.evolution-ews ];
  programs.firefox.nativeMessagingHosts.gsconnect = true;

  environment.systemPackages = [
    # Tool to convert dconf settings to Nix config
    pkgs.dconf2nix
    pkgs.thunderbird
  ];

  # Exclude broken packages
  environment.gnome.excludePackages = [];

  # --- Network ------------------------------------------------------

  # --- NetworkManager ---
  networking.networkmanager.enable = true;
  users.users."sam".extraGroups = [ "gdm" "netdev" "networkmanager" "nm-openconnect" ];

  # --- Styles -------------------------------------------------------

  # Qt uses GNOME styles
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";

  # Use GNOME-styled pinentry window for GnuPG
  programs.gnupg.agent.pinentryFlavor = "gnome3";


  # --- Services -----------------------------------------------------
  # --- Desktop --------------
  # Enable GNOME & GDM
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # --- GNOME ----------------
  services.gnome = {
    at-spi2-core.enable = true;
    core-developer-tools.enable = true;
    core-os-services.enable = true;
    core-shell.enable = true;
    core-utilities.enable = true;
    #evolution-data-server.enable = true;
    #evolution-data-server.plugins = [
    #];
    glib-networking.enable = true;
    gnome-browser-connector.enable = true;
    gnome-keyring.enable = true;
    gnome-online-accounts.enable = true;
    gnome-online-miners.enable = true;
    gnome-remote-desktop.enable = true;
    gnome-settings-daemon.enable = true;
    gnome-user-share.enable = true;
    sushi.enable = true;
    tracker.enable = true;
    tracker-miners.enable = true;
  };
  # --- Filesystems ----------
  services.gvfs = {
    enable = true;
    package = pkgs.gnome.gvfs;
  };

  # --- Flatpak --------------
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;

  #(lib.optionalAttrs (options?services.flatpak.packages) {
  #  services.flatpak.packages = [
  #    "flathub:org.gnome.Platform"     "flathub:org.gnome.Sdk"
  #    "flathub:org.kde.KStyle.Adwaita" "flathub:org.kde.PlatformTheme.QGnomePlatform" "flathub:org.kde.WaylandDecoration.QGnomePlatform-decoration"
  #  ];
  #})

}

