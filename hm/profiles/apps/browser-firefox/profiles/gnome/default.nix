{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  isGnome = config.gtk.enable;
in {
  # TODO: Recursively merge & override the default profile.
  programs.firefox.profiles.gnome = lib.mkIf isGnome {
    name = "GNOME";
    isDefault = true; # config.services.xserver.;
    package = pkgs.firefox.override {
      nativeMessagingHosts = [pkgs.tridactyl-native pkgs.gnome-browser-connector];
    };

    extensions =
      # with inputs.nur.repos.rycee.firefox-addons; [
      with pkgs.nur.repos.rycee.firefox-addons; [
        gnome-shell-integration
        gsconnect
      ];

    settings = {
      # --- Options: Defaults = Set ---
      "browser.theme.dark-private-windows" = false;
      "browser.uidensity" = 0;
      "svg.content-properties.content.enabled" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      # --- Options: Defaults = Unset ---
      "gnomeTheme.normalWidthTabs" = false;
      "gnomeTheme.closeOnlySelectedTabs" = true;
      "gnomeTheme.hideUnifiedExtensions" = false;
      "gnomeTheme.tabsAsHeaderbar" = false;
      # --- Options: Changed from default ---
      "gnomeTheme.activeTabContrast" = true;
      "gnomeTheme.bookmarksToolbarUnderTabs" = true;
      "gnomeTheme.hideWebrtcIndicator" = true;
      "gnomeTheme.symbolicTabIcons" = true;
      "gnomeTheme.systemIcons" = true;
    };

    # TODO: @import "${pkgs.nur.repos.federicoschonborn.firefox-gnome-theme}/userChrome.css";
    # https://raw.githubusercontent.com/easonwong-de/Tab-Preview-On-Hover/main/CSS%20Theme/userChrome.css
    userChrome = ''
      @import "firefox-gnome-theme/userChrome.css";
      @import "firefox-gnome-theme/theme/extensions/adaptive-tab-bar-color.css";
      @import "firefox-gnome-theme/theme/extensions/tab-center-reborn.css";
    '';
    userContent = ''
      @import "firefox-gnome-theme/userContent.css";
    '';
  };

  home.packages = [
    # https://github.com/rafaelmardojai/firefox-gnome-theme
    # TODO: Import this in userChrome / userContent
    pkgs.nur.repos.federicoschonborn.firefox-gnome-theme
  ];
}
