{...}: {
  networking.wireless.networks."That's No Moon" = {
    pskRaw = "ext:psk_mary";
    hidden = false;
    authProtocols = ["WPA-PSK"];
  };
  # networking.networkmanager.ensureProfiles.profiles.wifi-mary = {
  #   connection = {
  #     id = "wifi-mary";
  #     interface-name = "wlan0";
  #     type = "wifi";
  #     uuid = "8bbd0dd7-43d9-4ddd-987b-5d91f0cb1ee4";
  #   };
  #   ipv4.method = "auto";
  #   ipv6 = {
  #     addr-gen-mode = "default";
  #     method = "auto";
  #   };
  #   proxy = {};
  #   wifi = {
  #     mode = "infrastructure";
  #     ssid = "That's No Moon";
  #   };
  #   wifi-security = {
  #     auth-alg = "open";
  #     key-mgmt = "wpa-psk";
  #   };
  # };
}
