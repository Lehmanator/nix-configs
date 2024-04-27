{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
#
# Wrapped Firefox package with default extensions & policies
# - Import in NixOS options, home-manager options, nix-darwin options to share config.
#
# https://github.com/NixOS/nixpkgs/blob/master/doc/packages/firefox.section.md
#
lib.wrapFirefox pkgs.firefox-esr-unwrapped {
  # Install Firefox Addons
  # TODO: Create NUR repo for extensions missing from upstream + rycee's repo
  nixExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
    # Upstream Packaged Extensions
    # NUR Packaged Extensions
    # Unpackaged Extensions
    (pkgs.fetchFirefoxAddon {
      name = "privacy.com";
      url = "https://addons.mozilla.org/firefox/downloads/file/<hash>/<name>-<vers>-<variant>.xpi";
      hash = "sha256-<hash>";
    })
    (pkgs.fetchFirefoxAddon {
      name = "canvas-blocker";
      url = "https://addons.mozilla.org/firefox/downloads/file/<hash>/<name>-<vers>-<variant>.xpi";
      hash = "sha256-<hash>";
    })
    (pkgs.fetchFirefoxAddon {
      name = "adaptive-tab-bar-color";
      url = "https://addons.mozilla.org/firefox/downloads/file/<hash>/<name>-<vers>-<variant>.xpi";
      hash = "sha256-<hash>";
    })
  ];

  # https://github.com/mozilla/policy-templates/blob/master/linux/policies.json
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
      FeatureRecommendations = lib.mkDefault false;
      MoreFromMozilla = lib.mkDefault false;
      SkipOnboarding = true;
      UrlbarInterventions = lib.mkDefault false;
      WhatsNew = lib.mkDefault true;
      Locked = false;
    };
    SecurityDevices = {
      # Use a proxy module rather than `nixpkgs.config.firefox.smartcardSupport = true`
      "PKCS#11 Proxy Module" = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
    };
  };

  extraPrefs = ''
    // Show more ssl cert infos
    lockPref("security.identityblock.show_extended_validation", true);
  '';
}
