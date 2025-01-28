{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable Wi-Fi hotspot
  services.hostapd = {
    enable = true;
    package = pkgs.hostapd;

    radios.wlan0 = {
      # Frequence band to use
      # options: 2g | 5g | 6g | 60g
      band = "2g";

      # Wifi network channel
      # channel = 7;

      # Contry code to set regulatory domain # TODO: Set in locale profile
      countryCode = lib.mkDefault "US";

      # Wifi card driver
      # options: nl80211 | hostapd
      driver = "nl80211";

      dynamicConfigScripts = {};

      # Dont scan for overlapping BSSs in HT40+/- mode.
      # WARN: Violates regulatory reqs if true
      noScan = lib.mkDefault false;

      networks.wlan0 = {
        apIsolate = false;
        bssid = null;
        dynamicConfigScripts = {};

        # User group to allow to use hostapd
        group = "network";

        # Send empty SSID in beacons & ignore probe request frames that dont specify full SSID.
        # i.e. require stations to know SSID.
        # Options:
        # - disabled = advertise SSID normally
        # - empty = send empty (length=0) SSID in beacon & ignore probe request for broadcast SSID
        # - clear = clear SSID (ASCII 0), but keep the original length & ignore probe request for broadcast SSID.
        ignoreBroadcastSsid = "disabled";

        # Wi-Fi network
        ssid = "${config.networking.hostName}-hotspot";

        # options:
        # - deny = allow unless in macDeny
        # - allow = deny unless in macAllow
        # - radius = use external radius server, but check both macAllow & macDeny first
        macAcl = "deny";
        macAllowFile = config.sops.secrets.hostapd-mac-allow.path;
        macDenyFile = config.sops.secrets.hostapd-mac-deny.path;

        authentication = {
          # options: none | wpa2-sha1 | wpa2-sha256 | wpa3-sae-transition | wpa3-sae
          mode = "wpa2-sha256";
          pairwiseCiphers = ["CCMP"];
          saeAddToMacAllow = false;
          saePasswordsFile = config.sops.secrets.hostapd-sae-passwords.path;
          wpaPasswordFile = config.sops.secrets.hostapd-wpa-psk.path;
        };

        # Extra config options to put at end of this BSS's definition in hostapd.conf
        settings = {
          multi_ap = false;
        };
      };
    };
  };

  sops.secrets = {
    hostapd-password = {
      key = "hostapd-password";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
    hostapd-wpa-psk = {
      key = "hostapd-password";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
    hostapd-mac-allow = {
      key = "hostapd-mac-allow";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
    hostapd-mac-deny = {
      key = "hostapd-mac-deny";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
    hostapd-sae-passwords = {
      key = "hostapd-sae-passwords";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
    hostapd-wpa-password = {
      key = "hostapd-wpa-password";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
  };
}
