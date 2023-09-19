{ inputs, self
, config, lib, pkgs
, program ? "firefox"
, profile ? "default"
, ...
}:
{
  imports = [
  ];

  programs."${program}".profiles."${profile}" = {
    extensions = [ pkgs.nur.repos.rycee.firefox-addons.tabcenter-reborn ];
    settings = {
      "browser.tabs.inTitlebar" = 1;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "gnomeTheme.extensions.tabCenterReborn" = true;
      "gnomeTheme.extensions.tabCenterReborn.alwaysOpen" = false;
    };

    userChrome = ''
      @import ${pkgs.firefox-gnome-theme}/theme/extensions/tab-center-reborn.css;
    '' ++ (builtins.readFile ./tabcenter-reborn_userChrome.css);

    userContent = ''
    '' ++ (builtins.readFile ./tabcenter-reborn_userContent.css);

    # Extra preferences to add to user.js
    #extraConfig = ''
    #'';

  };
}
