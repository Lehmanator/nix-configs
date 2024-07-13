{ config, lib, ... }: {
  services.hostapd = {
    # Enable Wi-Fi hotspot
    enable = true;
    radios = {

      # Wi-Fi interface to use for hotspot.
      wlp166s0 = { #wlp3s0 = {
        # Wifi band (2g | 5g | 6g | 60g)
        band = "5g";

        # Wifi network channel
        # channel = 0;

        # Wifi card driver
        #driver = "nl80211";   # nl80211 | hostapd

        # Country code to set regulatory domain # TODO: Set in locale profile
        countryCode = "US";

        networks.wlp166s0 = { #wlp3s0 = {
          apIsolate = lib.mkDefault false;
          ssid = "${config.networking.hostName}-hotspot";
          authentication = {
            mode = "wpa2-sha256";
            # enableRecommendedPairwiseCiphers = true;
            # saePasswordFile = config.sops.secrets.wifi-hotspot-password.path;
            wpaPasswordFile = config.sops.secrets.wifi-hotspot-password.path;
          };
          # settings.multi_ap = true;
        };
        #settings = {  acs_exclude_dfs = true; };
        #wifi6.enable = true;
      };
    };
  };

  sops.secrets.wifi-hotspot-password = {};
}
