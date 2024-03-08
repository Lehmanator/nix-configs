# See all GNOME packages:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ inputs, config, lib, pkgs, user, ... }: {
  imports = [
    inputs.self.nixosProfiles.flatpak
    inputs.self.nixosProfiles.gdm
    inputs.self.nixosProfiles.gtk
    inputs.self.nixosProfiles.wayland

    #../../xwayland.nix
    ./extensions
  ];

  services.accounts-daemon.enable = lib.mkDefault true; # AccountsService: access user account list & info via D-Bus

  # --- Packages -----------------------------------------------------
  programs.evince.enable = lib.mkDefault true;
  programs.geary.enable = lib.mkDefault true;
  services.gnome.games.enable = lib.mkDefault true;

  # --- Evolution ---
  # TODO: Fix EWS support for Microsoft Exchange & Microsoft Graph API
  #programs.evolution = {
  #  enable = true;
  #  plugins = [pkgs.evolution-ews];
  #};
  #services.gnome.evolution-data-server = {
  #  enable = true;
  #  plugins = [pkgs.evolution-ews];
  #};

  # dconf: Settings configuration for apps
  programs.dconf.enable = true;
  environment.systemPackages = [
    pkgs.authenticator
    pkgs.gnome.gnome-software

    # --- Developer ---
    #pkgs.gitg # GTK GUI client for Git repos
    #pkgs.commit # GTK commit editor. Note: Not yet packaged in nixpkgs
    #pkgs.forge-sparks # Watcher & notifier for Git repos. Note: Not packaged yet in nixpkgs
    #pkgs.gnome.accerciser # Accessibility
    ##pkgs.gnome.anjuta  # Software dev studio (old)
    #pkgs.gnome.devhelp # API doc browser
    #pkgs.gnome.gnome-terminal
    #pkgs.gnome-builder
    #pkgs.gnome-console
    #pkgs.gnome-doc-utils
    #pkgs.gnome-keysign
    #pkgs.nautilus-python

    # --- Email ---
    pkgs.thunderbird
    # TODO: Package erooster-mail/email-client
    # https://github.com/erooster-mail/email-client

    # --- Remote ---
    pkgs.gnome-connections
    pkgs.remmina
    pkgs.gnomeExtensions.remmina-search-provider
  ] ++ lib.optionals config.programs.dconf.enable
    [ pkgs.dconf2nix ]; # Convert dconf settings to Nix

  # Exclude broken packages
  environment.gnome.excludePackages = [ ];

  # --- Keyring ------------------------------------------------------
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gsignond.enable = lib.mkDefault
    true; # D-Bus service to perform user auth on behalf of clients

  # Enable GNOME keyring PAM module for all services that unlock with password
  # TODO: See if possible to unlock gnome-keyring with other auth methods like SSH keys & fingerprint.
  security.pam.services.login.enableGnomeKeyring =
    config.services.gnome.gnome-keyring.enable;

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
  services.gnome.at-spi2-core.enable =
    true; # Accessibility services / assistive technologies for GNOME platform
  services.gnome.core-developer-tools.enable = true;
  services.gnome.core-os-services.enable = true;
  services.gnome.core-shell.enable = true;
  services.gnome.core-utilities.enable = true;
  services.gnome.gnome-settings-daemon.enable =
    true; # Settings storage daemon (for gsettings & programs/apps being able to react to settings changes)
  services.gnome.sushi.enable =
    true; # Nautilus file-manager file quick previewer
  services.gnome.tracker.enable = true; # Local search engine & metadata storage
  services.gnome.tracker-miners.enable =
    true; # Indexing services for tracker search engine & metadata storage

  # --- Filesystems ----------
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.${user}.extraGroups = [ "netdev" ]
    ++ lib.optionals config.networking.networkmanager.enable [
    "networkmanager"
    "nm-openconnect"
  ];
  services.gnome.glib-networking.enable = true;
  services.gnome.gnome-online-accounts.enable = lib.mkDefault true;
  services.gnome.gnome-online-miners.enable = lib.mkDefault true;
  services.gnome.gnome-remote-desktop.enable = lib.mkDefault true;
  services.gnome.gnome-user-share.enable = lib.mkDefault true;

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

  # --- Remote ---------------
  # TODO: Only set if using Wayland & xwayland
  #services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  [org.gnome.mutter.wayland]
  #  xwayland-grab-access-rules="['Remmina', 'xfreerdp']"
  #'';
}
