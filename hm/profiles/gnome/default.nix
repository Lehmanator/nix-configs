{ config, lib, pkgs, ... }:
let
  cfg = config.services.xserver;
  gnomeProfile = "default";
in
# TODO: Make directory: ../desktop/gnome/profiles
  # TODO: Make directory: ../desktop/gnome/profiles/default
  # TODO: Create file: ../desktop/gnome/secrets.nix
  # TODO: Create file: ../desktop/gnome/gtk4-force.nix

  # TODO: Create app directory structure: (GNOME Apps: ../desktop/gnome/apps), (Non-GNOME Apps: ../desktop/apps)
  # - ./<catName>.nix           - Misc app-related config grouped by categories. Use to install groups of apps
  # - ./<appName>/default.nix   - Set options, enable packages, etc.
  # - ./<appName>/settings.nix  - Set dconf settings
  # - ./<appName>/<profileName> - Same structure as parent directory, but only imported when using matching gnomeProfile

  # TODO: Create extension directory structure: ../desktop/gnome/extensions
  # - ./<catName>.nix           - Misc extension-related config grouped by categories. Use to install groups of extensions.
  # - ./<extName>/default.nix   - Set options, enable packages, etc.
  # - ./<extName>/settings.nix  - Set dconf settings
  # - ./<extName>/<profileName> - Same structure as parent directory, but only imported when using matching gnomeProfile
  #
  # TODO: Migrate existing GNOME / apps config to new structure
  # TODO: Create logic for specifying gnomeProfile
  # TODO: Create logic for specifying preferredGuiToolkit
  #  - TODO: Specify functionality desired, then import the appropriate app based on preferredGuiToolkit
  #  - TODO: Create user roles & have appropriate apps installed for that user's roles
  #
{
  imports = [
    # Extra home-manager modules
    # Options:
    #   # inputs.xhmm.homeManagerModules.desktop.gnome
    #   gnome = {
    #     font = types.nullOr hm.types.fontType;
    #     monospaceFont = types.nullOr hm.types.fontType;
    #     documentFont = types.nullOr hm.types.fontType;
    #     legacyTitlebarFont = types.nullOr hm.types.fontType;
    #     shellTheme = {
    #       package = "pkgs.adwaita";
    #       name = "Adwaita";
    #     };
    #     cursorTheme = {
    #       package = "pkgs.adwaita-cursor-theme";
    #       name = "Adwaita";
    #     };
    #     extensions = {
    #       enable = true;
    #       enabledExtensions = [ types.package ];
    #       extraExtensions = [ types.package ];
    #     };
    #   };
    # TODO: Re-enable this & use to install & enable gnomeExtensions, leaving imported, but unset disables extensions for users.
    #inputs.home-extra-xhmm.homeManagerModules.desktop.gnome

    #inputs.nix-software-center.packages.${system}.nix-software-center
    #inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    #inputs.snow.packages.${system}.snow

    ../desktop
    ../desktop/gtk.nix
    ../desktop/wayland.nix
    ./keyring.nix
    ./mobile.nix
    ./styles.nix
    ./apps # GNOME-specific apps
    ./extensions # GNOME Shell Extensions
  ];

  home.packages = with pkgs; [
    gnome-boxes
    totem

    # FIXME: Renamed pkgs: 24.05 -> unstable
    # gnome-autoar
    # gnome-font-viewer # Includes thumbnailer
    # gnome-packagekit
    # gnome-tweaks
    # simple-scan
    gnome-autoar
    gnome-font-viewer # Includes thumbnailer
    gnome-packagekit
    gnome-tweaks
    simple-scan

    gnome-connections
    #gnome-decoder
    gnome-firmware
    gnome-frog
    gnome-multi-writer
    gnome-recipes
    gtklp
  ];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf (cfg.desktopManager.gnome.enable == true) {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};

  xdg.mimeApps.defaultApplications = {
    #"audio/mpeg" = ["io.mpv.Mpv.desktop"];
    #"text/html" = [ "org.gnome.Epiphany.desktop" ];
    #"x-scheme-handler/https" = ["org.gnome.Epiphany.desktop"];
    #"x-scheme-handler/mailto" = ["org.gnome.Evolution.desktop"];
  };
}
