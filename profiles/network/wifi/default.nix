{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [
    #./backends/iwd.nix
    #./backends/wpa_supplicant.nix
    #./hotspot.nix
    #./networks
  ];
  networking = {
    # Wi-Fi networking config to apply to all connectino managers (NetworkManager, Conman, networkd, etc.)
    wireless = {
      dbusControlled = true; # Use D-Bous interface to control wifi netowrks. Only needed when using NetworkManager / connman
      # TODO: Create agenix / sops-nix config for Wi-Fi SSIDs & PSKs
      #environmentFile = "/run/secrets/wireless.env"; # Path to file containing environment vars referenced in config (wrap vars in @ signs)
      fallbackToWPA2 = true;
      scanOnLowSignal = true; # Scan for better networks on low signal on current SSID. Better connection, worse battery
      userControlled = {
        enable = true; # Allow users to control wifi networking
        group = "network"; # User group to allow to control wifi networking
      };
    };
    networkmanager.wifi = {
      backend = lib.mkDefault "wpa_supplicant"; # wpa_supplicant | iwd
      macAddress = lib.mkDefault "preserve"; # stable | preserve | permanent | random | <MAC_address>
      #powersave = lib.mkDefault null;
      scanRandMacAddress = true; # MAC addr randomization during scanning for networks
    };
    # Wi-Fi interface configuration
    #wlanInterfaces = {
    #  wlan-ap0 = {
    #    device = "wlp6s0";
    #    flags = null; # null | none | fcsfail | control | otherbss | cook | active
    #    fourAddr = null; # null | true | false
    #    mac = "02:00:00:00:00:03";
    #    meshID = null;
    #    type = "managed"; # ibss | mesh | monitor | managed | wds
    #  };
    #};
  };
}
