# See all GNOME packages:j
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ inputs, cell, config, lib, pkgs, user, ... }: {
  imports = with cell.nixosProfiles; [gdm gnome-apps gnome-extensions gtk wayland]; #xwayland

  # --- Packages -----------------------------------------------------
  environment = {
    gnome.excludePackages = [ ];
    systemPackages = [
    # dconf2nix: Convert dconf settings to Nix
    # TODO: Move to either home-manager or devshellProfiles.gnome
    ] ++ lib.optional config.programs.dconf.enable pkgs.dconf2nix; 
  };

  # --- Keyring ------------------------------------------------------
  # Enable GNOME keyring PAM module for all services that unlock with password
  # TODO: See if possible to unlock gnome-keyring with other auth methods like SSH keys & fingerprint.
  security.pam.services.login.enableGnomeKeyring = lib.mkIf config.services.gnome.gnome-keyring.enable true;
  services.gnome.gnome-keyring.enable = true;

  # D-Bus service to perform user auth on behalf of clients
  services.gsignond.enable = lib.mkDefault true;

  # --- Styles -------------------------------------------------------
  qt.style         = "adwaita-dark";  # Qt use GNOME styles
  qt.platformTheme = "gnome";

  # --- Services -----------------------------------------------------
  services.xserver.desktopManager.gnome = {
    enable = true;

    # Override timeout before showing app's '<App> is not responding' dialog (5s -> 20s)
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      check-alive-timeout=20000
    '';

    # Extra packages whose outputs are made available to GNOME
    sessionPath = [
      # Deps: gnomeExtensions.ddterm
      pkgs.gjs
      pkgs.libhandy
      pkgs.vte-gtk4
      pkgs.vte
    ];
  };

  # Accessibility services / assistive technologies for GNOME platform
  services.gnome.core-developer-tools.enable  = lib.mkDefault true;
  services.gnome.core-os-services.enable      = true; # DConf
  services.gnome.core-shell.enable            = true;
  services.gnome.core-utilities.enable        = true;
  # Enables gsettings & programs to listen for settings changes
  services.gnome.gnome-settings-daemon.enable = true;
  services.gnome.sushi.enable = true;          # Nautilus file previewer

  # --- Networking ----------
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.${user}.extraGroups = [ "netdev" ]
    ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" "nm-openconnect" ];

  # --- Remote ---------------
  # TODO: Only set if using Wayland & xwayland
  #services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  [org.gnome.mutter.wayland]
  #  xwayland-grab-access-rules="['Remmina', 'xfreerdp']"
  #'';
}
