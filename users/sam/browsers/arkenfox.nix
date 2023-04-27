{ self, inputs, config, lib, pkgs,
  ...
}:

# https://github.com/arkenfox/user.js
# https://arkenfox.github.io/gui/

let

  arkenfox = {
    base = builtins.readFile ./user.js;  # TODO: Use fetcher
    sections = {
      enable = true;
      "0000".enable = true;  # Global
      "0100".enable = true;  # Startup
      "0200".enable = true;  # Geolocation / Language / Locale
      "0300".enable = true;  # Quieter Fox
      "0400".enable = true;  # Safe Browsing
      "0600".enable = true;  # Block Implicit Outbound
      "0700".enable = true;  # DNS / DoH / Proxy / SOCKS / IPv6
      "0800".enable = true;  # Location Bar / Search Bar / Suggestions / History / Forms
      "0900".enable = true;  # Passwords
      "1000".enable = true;  # Disk Avoidance
      "1200".enable = true;  # TLS / SSL
      "1400".enable = true;  # Fonts
      "1600".enable = true;  # Headers / Referrers
      "1700".enable = true;  # Containers
      "2000".enable = true;  # Plugins / Media / WebRTC
      "2400".enable = true;  # DOM
      "2600".enable = true;  # Misc

      #"0000".enable = true;
      "0001".enable = true;
      "0002".enable = true;
      "0003".enable = true;
      "0004".enable = true;
      "0005".enable = true;
      "0006".enable = true;
      "0007".enable = true;
      "0008".enable = true;
      "0009".enable = true;
      "0010".enable = true;
      "0011".enable = true;
      "0012".enable = true;
      "0013".enable = true;
      "0014".enable = true;
      "0015".enable = true;
      "0016".enable = true;
      "0017".enable = true;
      "0018".enable = true;
      "0019".enable = true;
      "0020".enable = true;
      "0021".enable = true;
      "0022".enable = true;
      "0023".enable = true;
      "0024".enable = true;
      "0025".enable = true;
      "0026".enable = true;
    };

    # TODO: Add iPhone, Windows (1080p monitor) screen resolutions
    # TODO: Check 5000s (optional) & 9000s (personal)
    overrides.default = ''

      user_pref("browser.startup.page", 3);                       // Enable browser start page (3=restore-session)

      //user_pref("browser.formfill.enable", true);               // Enable form auto-fill

      //user_pref("security.cert_pinning.enforcement_level", 2);  //

      //user_pref("netowrk.http.referer.XOriginPolicy", 0);       // Pair w/ Smart Referer extension (Strict mode + add exceptions)

      user_pref("media.eme.enabled", true);                       // Allow DRM

      user_pref("privacy.clearOnShutdown.cache", false);          // [DEFAULT: true]
      user_pref("privacy.clearOnShutdown.downloads", false);      // [DEFAULT: true]
      user_pref("privacy.clearOnShutdown.formdata", true);        // [DEFAULT: true]
      user_pref("privacy.clearOnShutdown.history", false);        // [DEFAULT: true]
      user_pref("privacy.clearOnShutdown.sessions", false);       // [DEFAULT: true]

      user_pref("webgl.disabled", false);                         // [DEFAULT: true]

      //user_pref("privacy.resistFingerprinting.letterboxing", false); // Disable borders
      user_pref("privacy.resistFingerprinting.letterboxing.dimensions", "800x600, 1000x1000, 1920x1080"); // [HIDDEN PREF]
      // user_pref("privacy.window.maxInnerWidth", 1600); // 4502 [default 1600 in user.js v95]
      // user_pref("privacy.window.maxInnerHeight", 900);  // 4502 [default 900 in user.js v95]

      user_pref("browser.display.use_system_colors", true);
      user_pref("widget.non-native-theme.enabled", false);
      //user_pref("ui.use_standins_for_native_colors", "");

    '';

    overrides.loose = ''

    '';
  };

in
{
  # --- Arkenfox Flake ---
  #https://github.com/dwarfmaster/arkenfox-nixos
  #https://arkenfox.dwarfmaster.net
  #imports = [ inputs.arkenfox.hmModules.default ];
  programs.firefox.arkenfox = {
    enable = true;
    #version = "112.0";
  };
  programs.firefox.profiles.arkenfox.arkenfox = arkenfox.sections;
  programs.firefox.profiles.default.arkenfox = arkenfox.sections;

  # --- Manual Config ---
  #programs.firefox.profiles.arkenfox.extraConfig = arkenfox.base;
  #programs.firefox.profiles.default.extraConfig = arkenfox.base ++ arkenfox.overrides.default;

}
