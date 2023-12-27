{ inputs
, config
, lib
, pkgs
, ...
}:
let
  isGnome = config.gtk.enable;

  gnome-theme = builtins.fetchGit {
    url = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    rev = "ec9421f82d922b7293ffd45a47f7abdee80038c6";
  };
  hover-tab = builtins.fetchGit {
    url = "https://github.com/easonwong-de/Tab-Preview-On-Hover/tree/main/CSS%20Theme";
    rev = "585f559a1dbfc6effb460ece3c28d91d02a31472";
  };
  recolor-tab = builtins.fetchGit {
    url = "https://github.com/Redundakitties/colorful-minimalist";
    rev = "bbb1dbb855de6c0cccf9f9e712ad42e955568193";
  };
  sidebar = builtins.fetchGit {
    url = "https://github.com/drannex42/FirefoxSidebar";
    rev = "d99c43774b56226834c273c131563dfa9625f58d";
  };
  csshacks = builtins.fetchGit {
    url = "https://github.com/MrOtherGuy/firefox-csshacks";
    rev = "67a9e9f9c96e6d007b4c57f1dd7eaceaee135178";
  };
in
{
  # TODO: Recursively merge & override the default profile.
  programs.firefox.profiles.colors = lib.mkIf isGnome {
    name = "Colors";
    isDefault = true; #config.services.xserver.;
    package = pkgs.firefox.override {
      cfg.enableGnomeExtensions = true;
      cfg.enableTridactylNative = true;
    };

    # --- Extensions ---
    # Sidebery
    # https://addons.mozilla.org/en-US/firefox/addon/adaptive-tab-bar-colour
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [ gnome-shell-integration gsconnect ];

    # --- Settings ---
    # TODO: Load sidebery-data.json into Sidebery extension settings.
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
      # --- Color Blending ---
      "layout.css.backdrop-filter.force-enabled" = true;
      "layout.css.color-mix.enabled" = true;
      "layout.css.color-mix.color-spaces.enabled" = true;
    };

    # --- Browser chrome theming ---
    # TODO: @import "${pkgs.nur.repos.federicoschonborn.firefox-gnome-theme}/userChrome.css";
    # https://github.com/Redundakitties/colorful-minimalist
    # https://raw.githubusercontent.com/easonwong-de/Tab-Preview-On-Hover/main/CSS%20Theme/userChrome.css
    userChrome = ''
      @import url(${gnome-theme}/userChrome.css);
      @import url(${gnome-theme}/theme/extensions/adaptive-tab-bar-color.css);
      @import url(${gnome-theme}/theme/extensions/tab-center-reborn.css);
      @import url(${hover-tab}/CSS\ Theme/userChrome.css);
      @import url(${recolor-tab}/hacks/sideberyModsLEFT.css);
      /* sideberyModsLeftSlide.css, sideberyMods.css, menuShow.css */
      @import url(${sidebar}/userChrome.css);
      @import url(${sidebar}/themes/gtk_adwaita.css);
      @import url(${csshacks}/chrome/compact_extensions_panel.css);
      @import url(${csshacks}/chrome/urlbar_connection_type_text_colors.css);
      @import url(${csshacks}/chrome/urlbar_connection_type_background_colors.css);
      @import url(${csshacks}/chrome/urlbar_container_color_border.css);
      @import url(${csshacks}/chrome/multi-row-bookmarks.css);
      @import url(${csshacks}/chrome/page_action_buttons_on_urlbar_hover.css);
      /* @import url(${csshacks}/chrome/tab-hover-preview.css); */
      /* @import url(${csshacks}/chrome/autohide_sidebar.css); */
    '';

    # --- Browser content theming ---
    userContent = ''
      @import url(${gnome-theme}/userContent.css);
    '';

  };

  home.packages = [

    # https://github.com/rafaelmardojai/firefox-gnome-theme
    # TODO: Import this in userChrome / userContent
    pkgs.nur.repos.federicoschonborn.firefox-gnome-theme

  ];

}
