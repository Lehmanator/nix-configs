{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  hardware.wirelessRegulatoryDatabase = true;   # Load regulatory DB at boot

  # Wi-Fi networking config to apply to all connectino managers (NetworkManager, Conman, networkd, etc.)
  networking.wireless = {
    dbusControlled = true;     # Use D-Bous interface to control wifi netowrks. Only needed when using NetworkManager / connman

    # TODO: Create agenix / sops-nix config for Wi-Fi SSIDs & PSKs
    environmentFile = "/run/secrets/wireless.env";  # Path to file containing environment vars referenced in config (wrap vars in @ signs)
    fallbackToWPA2 = true;
    scanOnLowSignal = true;    # Scan for better networks on low signal on current SSID. Better connection, worse battery
    userControlled = {
      enable = true;           # Allow users to control wifi networking
      group = "network";       # User group to allow to control wifi networking
    };
  };
  networking.networkManager.wifi = {
    scanRandMacAddress = true;
    powersave = lib.mkDefault null;
    macAddress = lib.mkDefault "preserve";    # stable | preserve | permanent | random | <MAC_address>
    backend = lib.mkDefault "wpa_supplicant"; # wpa_supplicant | iwd
  };

  # Wi-Fi interface configuration
  networking.wlanInterfaces = {

    wlan-ap0 = {
      device = "wlp6s0";
      flags = null;               # null | none | fcsfail | control | otherbss | cook | active
      fourAddr = null;            # null | true | false
      mac = "02:00:00:00:00:03";
      meshID = null;
      type = "managed";           # ibss | mesh | monitor | managed | wds
    };

  };

}
