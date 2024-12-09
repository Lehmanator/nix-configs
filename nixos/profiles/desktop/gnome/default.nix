# See all GNOME packages:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/desktops/gnome/default.nix
# - pkgs/desktops/gnome
#   - All GNOME packages:  default.nix
#   - GNOME Installer Env: installer.nix
#   - Update GNOME:        updater.nix
{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./apps
    ./extensions

    ./audio.nix
    ./keyring.nix
    ./nautilus.nix
    ./network.nix

    "${inputs.self}/nixos/profiles/desktop/gtk.nix"
    "${inputs.self}/nixos/profiles/desktop/wayland.nix"
    # "${inputs.self}/nixos/profiles/desktop/xwayland.nix"
  ];

  # --- Services -----------------------------------------------------
  services = {
    displayManager.defaultSession = lib.mkDefault "gnome";
    xserver.desktopManager.gnome = {
      # Enable GNOME Shell
      enable = lib.mkForce true; 

      # Extend timeout before showing dialog: (5s -> 25s)
      #  '<App> is not responding'
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        check-alive-timeout=25000
      '';

      # Packages to add to GNOME session environment.
      #  Add binaries needed by gnomeExtensions
      sessionPath = [
        pkgs.gtop      # Process manager used by tophat extension
      ];
    };

    gnome = {
      at-spi2-core.enable = true; # Accessibility services / assistive technologies for GNOME platform
      core-developer-tools.enable = true;
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      gnome-settings-daemon.enable = true; # Settings storage daemon (for gsettings & programs/apps being able to react to settings changes)
      localsearch.enable = true; # Local search engine & metadata storage
      tinysparql.enable = true; # Indexing services for tracker search engine & metadata storage
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
      pkgs.gnome-tweaks
    ] ++ lib.optionals config.programs.dconf.enable [
      pkgs.dconf2nix
      pkgs.dconf-editor  # TODO: Remove from scope in 24.11
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

