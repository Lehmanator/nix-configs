{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Recursively merge & override the default profile.
  programs.firefox.profiles.base = {
    name = "base";
    id = "base";
    isDefault = false; # config.services.xserver.;

    bookmarks = [
      # Nix libs
      # Nix nix.conf manual
      # Home-Manager options
      # Home-Manager repo
      # nixpkgs repo

      # Personal web servers
    ];

    containers = {};

    #package = pkgs.firefox.override {
    #  nativeMessagingHosts = [pkgs.tridactyl-native]++lib.optional config.services.xserver.desktopManager.gnome.enable pkgs.gnome-browser-connector;
    #};

    #with inputs.nur.repos.rycee.firefox-addons; [
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [];

    search = {
      default = "DuckDuckGo";
      engines = {
        "DuckDuckGo" = {urls = [{template = "https://duckduckgo.com/";}];};
        "Nix Packages" = {
          definedAliases = ["@np" "@nixpkgs"];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
              ];
            }
          ];
        };
        # TODO: Move to NixOS profile
        "NixOS Options" = {
          definedAliases = ["@no" "@nixos"];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "type";
                  value = "options";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
              ];
            }
          ];
        };
        "NixOS Wiki" = {
          urls = [
            {
              template = "https://nixos.wiki/index.php?search={searchTerms}";
            }
          ];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = ["@nw" "@nixwiki"];
        };
      };
    };

    extraConfig = "";
    settings = {
      # --- Options: Defaults = Set ---
      "browser.theme.dark-private-windows" = false;
      "browser.uidensity" = 0;
      "svg.content-properties.content.enabled" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };

    # TODO: @import "${pkgs.nur.repos.federicoschonborn.firefox-gnome-theme}/userChrome.css";
    # https://raw.githubusercontent.com/easonwong-de/Tab-Preview-On-Hover/main/CSS%20Theme/userChrome.css
    userChrome = "";
    userContent = "";
  };

  home.packages = [];
}
