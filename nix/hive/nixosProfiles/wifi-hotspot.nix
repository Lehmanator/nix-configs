{ inputs, config, lib, pkgs, ... }: {
  services.hostapd = {
    # Enable Wi-Fi hotspot
    enable = true;

    # Wifi network channel
    #channel = 7;

    # Contry code to set regulatory domain # TODO: Set in locale profile
    countryCode = "US";

    #driver = "nl80211";   # nl80211 | hostapd        # Wifi card driver
    # User group to allow to use hostapd
    group = "network";

    # Wi-Fi interface to use for hotspot.
    #interface = "wlp2s0";

    # Wi-Fi operation mode. a=802.11a, b=802.11b, g=802.11g
    hwMode = "g";

    #logLevel = 2;
    # Dont scan for overlapping BSSs in HT40+/- mode. WARN: Violates regulatory reqs if true
    #noScan = false;

    ssid = "${config.networking.hostName}-hotspot"; # Wi-Fi network

    # Wi-Fi connection auth
    wpa = true;

    # TODO: Use secret
    wpaPassphrase = "${config.networking.hostName}-no-free-wifi";

    #extraConfig = ''
    #'';
  };

  #sops.secrets.wifi-hotspot-password = {};
}
