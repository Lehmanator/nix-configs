# See all GNOME packages:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ self, inputs
, config, lib, pkgs
, user ? "sam"
, ...
}:
#lib.attrsets.recursiveUpdate
{
  imports = [
    #./common.nix
    ./keyring.nix

    #../../autologin.nix { user = userPrimary; }
    ../../flatpak.nix
    ../../gtk.nix
    ../../wayland.nix
    #../../xwayland.nix
    ./apps
    ./extensions
  ];

  # --- Packages -----------------------------------------------------
  programs.evince.enable = true;

  # dconf: Settings configuration for apps
  programs.dconf.enable = true;
  environment.systemPackages = lib.mkIf config.programs.dconf.enable [ pkgs.dconf2nix ]; # Convert dconf settings to Nix

  # Exclude broken packages
  environment.gnome.excludePackages = [];

  # --- Network ------------------------------------------------------

  # --- NetworkManager ---
  networking.networkmanager.enable = true;
  users.users."${user}".extraGroups = lib.mkIf config.networking.networkmanager.enable ["netdev" "networkmanager" "nm-openconnect"];

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
    glib-networking.enable = true;
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

  #(lib.optionalAttrs (options?services.flatpak.packages) {
  #  services.flatpak.packages = [
  #    "flathub:org.gnome.Platform"     "flathub:org.gnome.Sdk"
  #    "flathub:org.kde.KStyle.Adwaita" "flathub:org.kde.PlatformTheme.QGnomePlatform" "flathub:org.kde.WaylandDecoration.QGnomePlatform-decoration"
  #  ];
  #})

}

