{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [ inputs.nur.modules.nixos.default ];
  #environment.systemPackages = [
  #  inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin
  #];

  nixpkgs.overlays = [ inputs.nur.overlays.default ];

  programs.firefox = {
    enable = true;
    package = inputs.flake-firefox-nightly.packages.${pkgs.system}.firefox-bin;
    #package = pkgs.firefox;



    # https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
    #autoConfig = ''
    #'';

    # https://github.com/mozilla/policy-templates/blob/master/README.md
    policies = {
      Bookmarks = [
      ];
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxAccounts = true; # TODO: Re-enable after hosting firefox sync server
      DontCheckDefaultBrowser = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      "3rdparty" = {
        Extensions = {
          # https://github.com/harshadgavali/searchprovider-for-browser-tabs
          "uBlock0@raymondhill.net" = {
            "adminSettings" = {
              "selectedFilterLists" = [
                "ublock-privacy"
                "ublock-badware"
                "ublock-filters"
                "user-filters"
              ];
            };
          };
        };
      };
    };

    preferences = { };

    preferencesStatus = "default";
  };

  #nativeMessagingHosts = {
  #  packages = [pkgs.tridactyl-native];
  #  ugetIntegrator = false;
  #  #tridactyl = true;
  #  passff = true;
  #  jabref = false;
  #  #gsconnect = config.programs.kdeconnect.enable;
  #  fxCast = true;
  #  ff2mpv = true;
  #  euwebid = true;
  #  bukubrow = true;
  #  browserpass = true;
  #};

  # TODO: Move to locale profile
  languagePacks = [ "en-US" "es-MX" "zh-CN" ];
}
