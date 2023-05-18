#{ self, modulesPath, inputs, outputs, config, lib, pkgs,
#  host, network, repo,
#  ...
#}:
#let
#  gnome-settings = import ./gnome.nix;
#in gnome-settings //
import ./gnome.nix
//
{
  #imports = [
  #  ./arkenfox.nix
  #  ./gnome.nix     # firefox-gnome-theme
  #];

  #programs.firefox.profiles.default.settings = {
  #};
  #profiles.firefox.profiles.default.settings = {
  #  "browser.startup.homepage" = "https://nixos.org";
  #  "browser.search.region" = "US";
  #  "browser.search.isUS" = true;
  #  "distribution.searchplugins.defaultLocale" = "en-US";
  #  "general.useragent.locale" = "en-US";
  #  "browser.bookmarks.showMobileBookmarks" = true;
  #  "browser.newtabpage.pinned" = [
  #    { title = "NixOS";  url = "https://nixos.org"; }
  #    { title = "Config"; url = "about:config";      }
  #  ];
  #};

}
