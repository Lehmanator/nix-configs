{ self
, inputs
, config
, lib
, pkgs
, ...
}:
let
  # TODO: Use fetchers from nixpkgs (bc non-blocking/async)
  gnome = builtins.fetchGit { url = "https://github.com/rafaelmardojai/firefox-gnome-theme"; rev = "ec9421f82d922b7293ffd45a47f7abdee80038c6"; };
  sidebar = builtins.fetchGit { url = "https://github.com/drannex42/FirefoxSidebar"; rev = "d99c43774b56226834c273c131563dfa9625f58d"; };
  csshacks = builtins.fetchGit { url = "https://github.com/MrOtherGuy/firefox-csshacks"; rev = "67a9e9f9c96e6d007b4c57f1dd7eaceaee135178"; };
  alpha = builtins.fetchGit { url = "https://github.com/Tagggar/Firefox-Alpha"; rev = "78bf9a9ea57538b0a58212731e81dea80d490105"; };
  impossible = builtins.fetchGit { url = "https://github.com/Naezr/ImpossibleFox"; rev = "a0a34595bc498abdab0e8c52c424762b994a6283"; };
  material = builtins.fetchGit { url = "https://github.com/muckSponge/MaterialFox"; rev = "8b1a7b10da0751a1f63e51eac428ba1eb1094b5f"; };
  rounded = builtins.fetchGit { url = "https://github.com/Etesam913/rounded-fox"; rev = "fbcffb41d67123f42a48430510991ba5503c0587"; };
  wave = builtins.fetchGit { url = "https://github.com/QNetITQ/WaveFox"; rev = "b4ddefc4e2bfccd7f809eca2b819e9a95ffbf2c2"; };

  combos = {
    default = ''
      @import url(firefox-gnome-theme/userChrome.css);
      @import url(csshacks/chrome/auto_devtools_theme.css);
      @import url(csshacks/chrome/auto_devtools_theme_for_rdm.css);
      @import url(csshacks/chrome/autohide_sidebar.css);
      @import url(csshacks/chrome/hide_tabs_scrollbuttons.css);
      @import url(csshacks/chrome/compact_extensions_panel.css);
      @import url(csshacks/chrome/compact_proton.css);
      @import url(csshacks/chrome/urlbar_info_icons_on_hover.css);
      @import url(csshacks/chrome/page_action_buttons_on_urlbar_hover.css);
      @import url(csshacks/chrome/drag_window_from_urlbar.css);
      @import url(csshacks/chrome/urlbar_connection_type_text_colors.css);
    '';

    # Shows single bar of tabs, with active tab becoming URL bar.
    # TODO: Fix hover, search box sizing/location, remove excess padding on right (by close icon),
    # TODO: Force active tab to stay in view, prefer ~25% sizing on hover, scroll other tabs to left/right behind (like accordion)
    # TODO: Show original UI elements in URLbox/tab.
    # TODO: Apply GNOME/Adwaita-like styles to tabs.
    singlebar = ''
      @import url(csshacks/chrome/hide_tabs_scrollbuttons.css);
      @import url(csshacks/chrome/selected_tab_as_urlbar.css);
      @import url(csshacks/chrome/click_selected_tab_to_focus_urlbar.css);
      @import url(csshacks/chrome/window_control_placeholder_support.css);
    '';
    # TODO: Tabs above urlbar/toolbar, fix missing window system icons (close), reverse search results box, offset search results by height of urlbar.
    bottom-nav = ''
      @import url(csshacks/chrome/toolbars_below_content.css);
      @import url(csshacks/chrome/tabs_below_content.css);
      @import url(csshacks/chrome/navbar_below_content.css);
      @import url(csshacks/chrome/linux_gtk_window_control_patch.css);
    '';
  };
  #hasGtk = config.services.xserver.desktopManager.gnome.enable || config.gtk.iconCache.enable;
  #hasSidebery = true; # TODO: Figure out how to deduce this from config.
  #hasAdaptive = true;
  #hasBreeze = config.qt.style == "breeze";
  #useGtk = (hasGtk || !hasBreeze);
in
{
  #userChrome = (import ./chrome/default.nix);
  userChrome = ''
    @import url(${gnome}/userChrome.css);
    @import url(${gnome}/theme/extensions/adaptive-tab-bar-color.css);
    @import url(${gnome}/theme/extensions/tab-center-reborn.css);
    @import url(${sidebar}/userChrome.css);
    @import url(${sidebar}/themes/gtk_adwaita.css);
    @import url(${csshacks}/chrome/auto_devtools_theme.css);
    @import url(${csshacks}/chrome/auto_devtools_theme_for_rdm.css);
    @import url(${csshacks}/chrome/autohide_sidebar.css);
    @import url(${csshacks}/chrome/compact_extensions_panel.css);
    @import url(${csshacks}/chrome/compact_proton.css);
    @import url(${csshacks}/chrome/drag_window_from_urlbar.css);
    @import url(${csshacks}/chrome/hide_tabs_scrollbuttons.css);
    @import url(${csshacks}/chrome/multi-row-bookmarks.css);
    @import url(${csshacks}/chrome/page_action_buttons_on_urlbar_hover.css);
    @import url(${csshacks}/chrome/urlbar_connection_type_text_colors.css);
    @import url(${csshacks}/chrome/urlbar_container_color_border.css);
    @import url(${csshacks}/chrome/urlbar_info_icons_on_hover.css);
    #TabsToolbar {
      display: none;
    }
    #sidebar-header {
      display: none;
    }
  '';
  #@import "${csshacks}/chrome/tab-hover-preview.css";  # TODO: No CSS file, found elsewhere?

  #userChrome = lib.mkIf (useGtk || hasSidebery)
  #''
  #  @import "${gnome}/userChrome.css";
  #  @import "${if hasSidebery then "${sidebery}/userChrome.css" else "${gnome}/theme/extensions/tab-center-reborn.css"}";
  #  @import "${sidebar}/themes/gtk_${if hasBreeze then "breeze.css" else "adwaita.css"}";
  #  ${optionalString hasAdaptive "@import \"${gnome}/theme/extensions/adaptive-tab-bar-color.css\";}
  #'';
  # --- ORIGINAL ---
  #userChrome = ''
  #  @import "firefox-gnome-theme/userChrome.css";
  #  @import "firefox-gnome-theme/theme/extensions/adaptive-tab-bar-color.css";
  #  @import "firefox-gnome-theme/theme/extensions/tab-center-reborn.css";
  #  @import "firefox-sidebar/userChrome.css";
  #  @import "firefox-sidebar/themes/gtk_adwaita.css";
  #'';
  # @import "firefox-gnome-theme/userChrome.css";
  # @import "rounded-fox/userchrome.css";
  # @import "firefox-csshacks/.css";
  # @import "CompactFox/.css";

  userContent = (import ./content/default.nix);
  # @import "firefox-gnome-theme/userContent.css";
}
#
# --- Themes ---
# https://github.com/rafaelmardojai/firefox-gnome-theme  (Use: Adwaita theme)
# https://github.com/drannex42/FirefoxSidebar            (Use: Auto-hide sidebar)
# https://github.com/QNetITQ/WaveFox                     (Use: Tab shape options, shared URL & tab bar)
# https://github.com/Naezr/ImpossibleFox                 (Use: URL bar inside tab, multi-line tab bar)
# https://github.com/Tagggar/Firefox-Alpha               (Use: Blend bars into background)
# https://github.com/Etesam913/rounded-fox               (Use: Hiding URL bar, inner rounded content corners)
# https://github.com/black7375/Firefox-UI-Fix
# https://github.com/Tnings/CompactFox
# https://gist.github.com/qaz69wsx/1739d185cff0a15929ac04c3f277a525 (Use: Compact unified extensions menu)
#
# --- Extensions ---
# https://github.com/mbnuqw/sidebery
# https://addons.mozilla.org/ru/firefox/addon/adaptive-tab-bar-colour/
#
# --- Desires ---
# - Multi-row tab bar
# - URL bar in active tab
# - Auto-hide sidebar until hover
# - Auto-hide navigation buttons when inaccessible
# - Auto-hide navigation buttons until hover
# - Auto-hide URL bar icons until hover
# - Compact extension menus
# - Adaptive recolor to page contents
# - Colored URL bar to show HTTPS status
# - Hide sidebar header row





#csshack-list = [
#  "auto_devtools_theme_for_rdm.css"
#  "autohide_bookmarks_and_main_toolbars.css"
#  "autohide_bookmarks_toolbar.css"
#  "autohide_main_toolbar.css"
#  "autohide_menubar.css"
#  "autohide_navigation_button.css"
#  "autohide_sidebar.css"
#  "autohide_tabstoolbar.css"
#  "autohide_toolbox.css"
#  "button_effect_icon_glow.css"
#  "button_effect_scale_onclick.css"
#  "button_effect_scale_onhover.css"
#  "buttonlike_toolbarbuttons.css"
#  "centered_statuspanel.css"
#  "centered_tab_content.css"
#  "centered_tab_label.css"
#  "classic_firefox_menu_button.css"
#  "classic_grid_main_menu_popup.css"
#  "click_selected_tab_to_focus_urlbar.css"
#  "color_variable_template.css"
#  "combined_favicon_and_tab_close_button.css"
#  "combined_tabs_and_main_toolbars.css"
#  "compact_extensions_panel.css"
#  "compact_proton.css"
#  "compact_urlbar_megabar.css"
#  "context_menus_more_proton.css"
#  "curved_tabs.css"
#  "custom_default_tab_favicons.css"
#  "custom_menupopup_check_icons.css"
#  "dark_checkboxes_and_radios.css"
#  "disable_newtab_on_middle_click.css"
#  "drag_window_from_urlbar.css"
#  "fake_statusbar_w_bookmarksbar.css"
#  "fake_statusbar_w_menubar.css"
#  "fake_tab_tooltip.css"
#  "fake_urlbar_dropmarker.css"
#  "grid_overflow_menu.css"
#  "hide_statuspanel_when_fullscreen.css"
#  "hide_tabs_scrollbuttons.css"
#  "hide_tabs_toolbar.css"
#  "hide_tabs_toolbar_osx.css"
#  "hide_tabs_toolbar_w_alltabs_button.css"
#  "hide_tabs_with_one_tab.css"
#  "hide_tabs_with_one_tab_w_window_controls.css"
#  "hide_toolbox_top_bottom_borders.css"
#  "hide_urlbar_first_row.css"
#  "icon_only_tabs.css"
#  "iconized_main_menu.css"
#  "iconized_menubar_items.css"
#  "inline_tab_audio_icons.css"
#  "integrated_searchbar_popup.css"
#  "less_static_throbber.css"
#  "linux_gtk_window_control_patch.css"
#  "loading_indicator_bounding_line.css"
#  "loading_indicator_rotating_image.css"
#  "menubar_in_main_toolbar.css"
#  "menubar_in_tabs_toolbar.css"
#  "menubar_in_tabs_toolbar_oneliner_compatible.css"
#  "menulike_bookmarks_folder_popups.css"
#  "menupopup_forced_color_schemes.css"
#  "minimal_in-UI_scrollbars.css"
#  "minimal_text_fields.css"
#  "minimal_toolbarbuttons.css"
#  "minimal_toolbarbuttons_v2.css"
#  "minimal_toolbarbuttons_v3.css"
#  "more_visible_tab_icon.css"
#  "multi-row_bookmarks.css"
#  "multi-row_main_toolbar.css"
#  "multi-row_oneliner_combo_patch.css"
#  "multi-row_tabs.css"
#  "multi-row_tabs_below_content.css"
#  "multi-row_tabs_separate_pinned_row_patch.css"
#  "multi-row_tabs_window_control_patch.css"
#  "navbar_below_content.css"
#  "navbar_tabs_oneliner.css"
#  "navbar_tabs_oneliner_menu_buttons_on_right.css"
#  "navbar_tabs_oneliner_tabs_on_left.css"
#  "navbar_tabs_responsive_oneliner.css"
#  "navigation_buttons_inside_urlbar.css"
#  "newtab_button_always_on_hover.css"
#  "non_floating_sharp_tabs.css"
#  "normal_pinned_tabs.css"
#  "numbered_tabs.css"
#  "overlay_menubar.css"
#  "overlay_sidebar_header.css"
#  "overlay_tab_audio_icons.css"
#  "page_action_buttons_on_hover.css"
#  "page_action_buttons_on_urlbar_hover.css"
#  "pinned_tabs_on_right.css"
#  "privatemode_indicator_as_menu_button.css"
#  "proton_dark_light_notifications.css"
#  "reload_button_in_urlbar.css"
#  "round_caption_buttons.css"
#  "round_ui_items.css"
#  "rounded_menupopups.css"
#  "scrollable_menupopups.css"
#  "scrollable_urlbar_popup.css"
#  "selected_tab_as_urlbar.css"
#  "selected_tab_gradient_border.css"
#  "sharp_menupopup_corners.css"
#  "show_navbar_on_focus_only.css"
#  "show_toolbars_in_popup_windows.css"
#  "show_window_title_in_menubar.css"
#  "shrinking_pinned_tabs.css"
#  "status_inside_menubar.css"
#  "status_inside_urlbar.css"
#  "status_inside_urlbar_v2.css"
#  "tab_animated_active_border.css"
#  "tab_close_button_always_on_hover.css"
#  "tab_closing_animation.css"
#  "tab_effect_scale_onclick.css"
#  "tab_line_loading_indicator.css"
#  "tab_loading_progress_bar.css"
#  "tab_loading_progress_throbber.css"
#  "tab_separator_lines.css"
#  "tabs_animated_gradient_border.css"
#  "tabs_below_content.css"
#  "tabs_fill_available_width.css"
#  "tabs_on_bottom.css"
#  "tabs_on_bottom_menubar_on_top_patch.css"
#  "textual_context_navigation.css"
#  "textual_searchbar_one-offs.css"
#  "toggle_tabs_toolbar_with_alt.css"
#  "toolbarbuttons_icon+label.css"
#  "toolbarbuttons_in_tabs_periphery.css"
#  "toolbars_below_content.css"
#  "urlbar_centered_text.css"
#  "urlbar_connection_type_background_colors.css"
#  "urlbar_connection_type_text_colors.css"
#  "urlbar_container_color_border.css"
#  "urlbar_info_icons_on_hover.css"
#  "urlbar_popup_full_width.css"
#  "urlbar_results_in_two_rows.css"
#  "urlbar_visible_on_active_tab_click.css"
#  "verical_bookmarks_toolbar.css"
#  "verical_context_navigation.css"
#  "verical_context_navigation_v2.css"
#  "verical_menubar.css"
#  "verical_popup_menubar.css"
#  "verical_tabs.css"
#  "verical_urlbar_one-off_items.css"
#  "window_control_fallback_for_custom_windows_theme.css"
#  "window_control_force_linux_system_style.css"
#  "window_control_placeholder_support.css"
#];
