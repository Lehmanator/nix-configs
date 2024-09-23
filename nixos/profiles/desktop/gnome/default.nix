# See all GNOME packages:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ config, lib, pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./keyring.nix
    ./nautilus.nix
    ./network.nix
    #../../autologin.nix { inherit user; }
    ../../gtk.nix
    ../../wayland.nix
    #../../xwayland.nix
    ./apps
    ./extensions
  ];

  # --- Services -----------------------------------------------------
  services = {
    xserver.displayManager.defaultSession = lib.mkDefault "gnome";
    xserver.desktopManager.gnome = {
      enable = lib.mkForce true; # Enable GNOME Shell

      # Extend timeout before showing '<App> is not responding' dialog (5s -> 20s)
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        check-alive-timeout=20000
      '';
    };

    gnome = {
      at-spi2-core.enable = true; # Accessibility services / assistive technologies for GNOME platform
      core-developer-tools.enable = true;
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      gnome-settings-daemon.enable = true; # Settings storage daemon (for gsettings & programs/apps being able to react to settings changes)
      tracker.enable = true; # Local search engine & metadata storage
      tracker-miners.enable = true; # Indexing services for tracker search engine & metadata storage
    };
    #(lib.optionalAttrs (options?services.flatpak.packages) {
    #  flatpak.packages = [
    #    "flathub:org.gnome.Platform"     "flathub:org.gnome.Sdk"
    #    "flathub:org.kde.KStyle.Adwaita" "flathub:org.kde.PlatformTheme.QGnomePlatform" "flathub:org.kde.WaylandDecoration.QGnomePlatform-decoration"
    #  ];
    #})
  };

  # --- Packages -----------------------------------------------------
  programs.evince.enable = true;

  # dconf: Settings configuration for apps
  programs.dconf.enable = true;
  environment = {
    systemPackages = [
      pkgs.gnome-randr  # Xrandr-like CLI for configuring displays on GNOME Wayland
      pkgs.gnome-tecla  # Keyboard layout viewer
      pkgs.gnomecast    # Native Linux GUI for Chromecasting local files.
      pkgs.gnome.gnome-tweaks
    ] ++ lib.optionals config.programs.dconf.enable [
      pkgs.dconf2nix
      pkgs.dconf-editor
    ]; # Convert dconf settings to Nix

    # Exclude broken packages
    gnome.excludePackages = [ ];
  };

  # --- Styles -------------------------------------------------------
  # Qt uses GNOME styles
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

}

