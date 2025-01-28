{...}: {
  networking.wireless.networks.Lehman = {
    pskRaw = "ext:psk_home";
    hidden = false;
    authProtocols = ["WPA-PSK"];
  };
  # networking.networkmanager.ensureProfiles.profiles.wifi-home = {
  #   connection = {
  #     id = "wifi-home";
  #     interface-name = "wlan0";
  #     type = "wifi";
  #     uuid = "951629b1-3eeb-417f-98a0-7ff343506458";
  #   };
  #   ipv4 = {
  #     address1 = "192.168.1.30/24,192.168.1.1";
  #     dns = "1.1.1.1;9.9.9.9";
  #     method = "manual";
  #   };
  #   ipv6 = {
  #     addr-gen-mode = "default";
  #     dns = "2606:4700:4700::1111;2606:4700:4700::1001;";
  #     ignore-auto-dns = "true";
  #     method = "auto";
  #   };
  #   proxy = {};
  #   wifi = {
  #     cloned-mac-address = "stable";
  #     mode = "infrastructure";
  #     ssid = "Lehman";
  #   };
  #   wifi-security = {
  #     key-mgmt = "wpa-psk";
  #     psk = "$WIFI_PASSWORD_HOME";
  #   };
  # };
}
