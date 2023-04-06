{
  self, modulesPath,
  inputs, outputs,
  config, lib, pkgs,
  host, network, repo,
  ...
}:
let
  # https://github.com/rafaelmardojai/firefox-gnome-theme
  gnome-theme = {
    settings = {
      # --- Defaults Set ---
      "browser.theme.dark-private-windows" = false;
      "browser.uidensity" = 0;
      "svg.content-properties.content.enabled" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      # --- Defaults Unset ---
      "gnomeTheme.normalWidthTabs" = false;
      "gnomeTheme.closeOnlySelectedTabs" = true;
      "gnomeTheme.hideUnifiedExtensions" = false;
      "gnomeTheme.tabsAsHeaderbar" = false;
      # --- Changed Options ---
      "gnomeTheme.activeTabContrast" = true;
      "gnomeTheme.bookmarksToolbarUnderTabs" = true;
      "gnomeTheme.dragWindowHeaderbarButtons" = true;
      "gnomeTheme.hideWebrtcIndicator" = false;
      "gnomeTheme.symbolicTabIcons" = true;
      "gnomeTheme.systemIcons" = true;
    };

    userChrome = ''
      @import "firefox-gnome-theme/userChrome.css";
    '';

    # TODO: Create package for this
    userContent = ''
      @import "firefox-gnome-theme/userContent.css";
    '';
  };
in
{
  #programs.firefox.profiles.default.settings = {
  #};
}
