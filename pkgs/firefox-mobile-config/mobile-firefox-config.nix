#  nix-build -E 'with import <nixpkgs> {}; pkgs.callPackage ./. {}' ; nix-env -i result/

{ stdenv
, lib
, fetchzip
, wrapFirefox
, firefox-esr-unwrapped
, fetchFirefoxAddon }:
with { inherit (builtins) readFile replaceStrings; };
let
    pmaConfig =
      stdenv.mkDerivation {
        pname = "pma-mobile-firefox-config";
        version = "2022-01-09-16a4471b";
        src = fetchzip {
          url = "https://gitlab.com/postmarketOS/mobile-config-firefox/-/archive/16a4471b733837b9152cea6a50cfdeb52410f6cb/mobile-config-firefox-16a4471b733837b9152cea6a50cfdeb52410f6cb.zip";
          hash = "sha256-XeHXCpCsy4vV+yxNHHAqkn9HzXhxDQcaP4YJbAM5S+w=";
        };
        postPatch = ''
          sed -i.bak src/mobile-config-autoconfig.js -e 's@/etc/mobile-config-firefox/@${placeholder "out"}/etc/mobile-config-firefox/@g'
          # remove the autoconfig prefs here, we use the Nixpkgs
          # autoconfig instead
          sed -i.bak src/mobile-config-prefs.js -e '/general.config/d'
        '';
        makeFlags = [
          "DESTDIR=${placeholder "out"}"
          "FIREFOX_DIR=/lib/firefox"
        ];
      };
in  wrapFirefox firefox-esr-unwrapped {
  nixExtensions = [
    (fetchFirefoxAddon {
      name = "ublock"; # Has to be unique!
      url = "https://addons.mozilla.org/firefox/downloads/file/3679754/ublock_origin-1.31.0-an+fx.xpi";
      sha256 = "1h768ljlh3pi23l27qp961v1hd0nbj2vasgy11bmcrlqp40zgvnr";
    })
  ];
  extraPolicies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = true;
    FirefoxHome = {
      Pocket = false;
      Snippets = false;
    };
    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };

    SearchEngines = {
      Default = "DuckDuckGo";
    };
  };

  extraPrefs =
    builtins.concatStringsSep "\n" [
      (readFile "${pmaConfig}/lib/firefox/mobile-config-autoconfig.js")
      (readFile "${pmaConfig}/lib/firefox/defaults/pref/mobile-config-prefs.js")
    ];
}
