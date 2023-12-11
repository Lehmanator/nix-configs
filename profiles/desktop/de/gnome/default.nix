# See all GNOME packages:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ inputs
, config
, lib
, pkgs
, ...
}:
#lib.attrsets.recursiveUpdate
{
  imports = [
    #./common.nix
    ./audio.nix
    ./gdm.nix
    ./keyring.nix
    ./network.nix

    #../../autologin.nix { inherit user; }
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
  environment.gnome.excludePackages = [ ];

  # --- Styles -------------------------------------------------------
  # Qt uses GNOME styles
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # --- Services -----------------------------------------------------
  # --- GNOME ----------------
  services.xserver.desktopManager.gnome = {
    # Enable GNOME Shell
    enable = true;

    # Override timeout before showing app's '<App> is not responding' dialog (5s -> 20s)
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      check-alive-timeout=20000
    '';
  };
  services.gnome = {
    at-spi2-core.enable = true; # Accessibility services / assistive technologies for GNOME platform
    core-developer-tools.enable = true;
    core-os-services.enable = true;
    core-shell.enable = true;
    core-utilities.enable = true;
    gnome-settings-daemon.enable = true; # Settings storage daemon (for gsettings & programs/apps being able to react to settings changes)
    sushi.enable = true; # Nautilus file-manager file quick previewer
    tracker.enable = true; # Local search engine & metadata storage
    tracker-miners.enable = true; # Indexing services for tracker search engine & metadata storage
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

