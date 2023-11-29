{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  services.hostapd = {
    enable = true; # Enable Wi-Fi hotspot
    #channel = 7;                                     # Wifi network channel
    countryCode = "US"; # Contry code to set regulatory domain # TODO: Set in locale profile
    #driver = "nl80211";   # nl80211 | hostapd        # Wifi card driver
    group = "network"; # User group to allow to use hostapd
    #interface = "wlp2s0";                            # Wi-Fi interface to use for hotspot.
    hwMode = "g"; # Wi-Fi operation mode. a=802.11a, b=802.11b, g=802.11g
    #logLevel = 2;
    #noScan = false;                                  # Dont scan for overlapping BSSs in HT40+/- mode. WARN: Violates regulatory reqs if true
    ssid = "${config.networking.hostname}-hotspot"; # Wi-Fi network
    wpa = true; # Wi-Fi connection auth
    wpaPassphrase = "${config.networking.hostname}-no-free-wifi";
    #extraConfig = ''
    #'';
  };
}
