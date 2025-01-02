{ inputs, config, lib, pkgs, ... }:
{
  programs.firefox.profiles.default = {
    name = "Default";
    isDefault = true;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      firemonkey
      adnauseam
      behave
      canvasblocker
      clearurls
      localcdn
      multi-account-containers
      noscript
      privacy-badger
      privacy-pass
      skip-redirect
      smart-referrer
      ubo-scope
      buster-captcha-solver
      ninja-cookie
      gnome-shell-integration
      gsconnect
      lovely-forks
      react-devtools
      wayback-machine
      floccus
      export-tabs-urls-and-titles
      sidebery
      simple-tab-groups
      tab-session-manager
      tab-stash
    ];

    search = {
      default = "DuckDuckGo";
      engines = import ../../search { inherit inputs pkgs; };
    };

    bookmarks = import ../../bookmarks;
    settings    = import ../../settings;
    userChrome  = import ../../styles/chrome;
    userContent = import ../../styles/content;
  };
}
