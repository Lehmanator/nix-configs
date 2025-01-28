{...}: {
  networking.wireless.networks = {
    "PIWC" = {
      pskRaw = "ext:psk_work";
      authProtocols = ["WPA-PSK"];
      hidden = false;
    };
    "PIWC-5G" = {
      pskRaw = "ext:psk_work";
      authProtocols = ["WPA-PSK"];
      hidden = false;
    };
    "!Piwine!" = {
      pskRaw = "ext:psk_work";
      authProtocols = ["WPA-PSK"];
      hidden = false;
    };
  };
}
