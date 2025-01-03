{ inputs, config, lib, pkgs, ... }:
{
  imports = [(inputs.self + /nixos/profiles/nur.nix)];
  home-manager.sharedModules = [(inputs.self + /hm/profiles/firefox)];
  
  programs.firefox = {
    enable = true;
    package = inputs.firefox.packages.${pkgs.system}.firefox-bin;

    # https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
    # autoConfig = ''
    # '';

    # https://github.com/mozilla/policy-templates/blob/master/README.md
    policies = {
      Bookmarks = [ ];
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
    
    nativeMessagingHosts = {
      packages = [pkgs.tridactyl-native];
      # ugetIntegrator = false;
      # #tridactyl = true;
      # passff = true;
      # jabref = false;
      # #gsconnect = config.programs.kdeconnect.enable;
      # fxCast = true;
      # ff2mpv = true;
      # euwebid = true;
      # bukubrow = true;
      # browserpass = true;
    };

    # TODO: Move to locale profile
    languagePacks = [ "en-US" "es-MX" "zh-CN" ];
  
  };

  # Nixpkgs Package Names: pkgs.firefox-{,beta,devedition,esr}{,-bin}{,-unwrapped}
  # environment.systemPackages = [
  #   # pkgs.firefox_decrypt  # Decrypt Firefox passwords from profiles
  #   # pkgs.firefoxpwa       # Util to install PWAs in Firefox (native component)
  # ] ++ (lib.optionals pkgs.stdenv.isx86_64 (with inputs.firefox.packages.${pkgs.system}; [
  #   # firefox-nightly-bin
  # ])); 

}
