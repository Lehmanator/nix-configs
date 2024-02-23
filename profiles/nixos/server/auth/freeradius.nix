{ inputs, config, lib, pkgs, ... }: {
  imports = [
  ];

  services.freeradius = {
    enable = true;
    debug = true;
    configDir = "/etc/raddb";
  };

  services.hostapd = {
    enable = true;
    radios = {
      "name" = {
        driver = "nl80211";
        macAcl = "radius";  # radius | allow | deny
        band = "2g";  # 2g | 5g | 6g | 60g
        channel = 7;
        countryCode = "US";
        dynamicConfigScripts = {};
        networks = {
          "name" = {
            apIsolate = true;
            authentication = {
              enableRecommendedPairwiseCiphers = true;
              mode = "";
              pairwiseCiphers = "";
              saeAddToMacAllow = "";
              saePasswords = [
                { id = ""; mac = ""; pk = ""; vlanId = ""; saePasswordsFile = ""; }
              ];
              wpaPassword = "";
              wpaPskFile = "";
            };
            bssid = "";
            dynamicConfigScripts = {};
            group = "";
            ignoreBroadcastSsid = false;
            logLevel = "INFO";
            macAcl = {};
            macAllow = {};
            macAllowFile = "";
            macDeny = {};
            macDenyFile = "";
            managementFrameProtection = "";
            settings = {};
            ssid = "";
            utf8Ssid = "";

          };
        };
        noScan = false;
        settings = {};
        wifi4 = { capabilities = {}; enable = true; require = true; };
        wifi5 = { capabilities = {}; enable = true; require = true; };
        wifi6 = { capabilities = {}; enable = true; require = true;
          multiUserBeamformer = true; operatingChannelWidth = "20or40"; # 20or40 | 80 | 160 | 80+80
          singleUserBeamformer = true; singleUserBeamformee = true;
        };
        wifi7 = { capabilities = {}; enable = true; require = true;
          multiUserBeamformer = true; operatingChannelWidth = "20or40"; # 20or40 | 80 | 160 | 80+80
          singleUserBeamformer = true; singleUserBeamformee = true;
        };
      };
    };
  };

}
