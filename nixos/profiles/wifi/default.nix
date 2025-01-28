{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [./networks];

  # Wi-Fi networking config to apply to all connection managers (NetworkManager, Conman, networkd, etc.)
  networking.wireless = {
    allowAuxiliaryImperativeNetworks = true;

    # Use D-Bous interface to control wifi netowrks.
    # Only needed when using NetworkManager / connman
    dbusControlled = true;

    # Fallback to WPA2 auth protocols if WPA3 fails.
    # Allows old wireless cards (lacking recent features required by WPA3) to connect to mixed WPA2/3 access points.
    # Disable to avoid possible downgrade attacks
    fallbackToWPA2 = lib.mkDefault true;

    # The interfaces wpa_supplicant will use.
    # If empty, it will automatically use all wireless interfaces.
    # Separate wpa_supplicant instances will be started for each interface.
    interfaces = [];

    # Scan for better networks on low signal on current SSID. Better connection, worse battery
    scanOnLowSignal = true;

    # File containing Wi-Fi passwords
    # Format: psk_<network>=<password>
    secretsFile = config.sops.secrets.wifi-passwords.path;

    # Allow users to control wifi networking
    userControlled = {
      enable = true;
      group = "network";
    };
  };

  # Files to load as environment file.
  # Environment variables from file will be substituted into static config file
  # using envsubst: https://github.com/a8m/envsubst
  networking.networkmanager.ensureProfiles.environmentFiles = [config.sops.secrets.wifi-environment.path];

  # https://networkmanager.dev/docs/api/latest/nm-settings-keyfile.html
  # https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/assembly_networkmanager-connection-profiles-in-keyfile-format_configuring-and-managing-networking
  # Conversion tool: https://github.com/janik-haag/nm2nix
  # `$ nix run git+https://github.com/janik-haag/nm2nix#nm2nix`
  # networking.networkmanager.ensureProfiles.profiles = { };

  networking.networkmanager.wifi = {
    backend = lib.mkDefault "wpa_supplicant"; # options: wpa_supplicant | iwd
    macAddress = lib.mkDefault "random"; # options: stable | preserve | permanent | random | <MAC_address>
    powersave = lib.mkDefault true;
    scanRandMacAddress = true; # MAC addr randomization during scanning for networks
  };

  # Wi-Fi interface configuration
  # networking.wlanInterfaces = {
  #   wlan-ap0 = {
  #     device = "wlp6s0";
  #     flags = null; # null | none | fcsfail | control | otherbss | cook | active
  #     fourAddr = null; # null | true | false
  #     mac = "02:00:00:00:00:03";
  #     meshID = null;
  #     type = "managed"; # ibss | mesh | monitor | managed | wds
  #   };
  # };

  sops.secrets = {
    wifi-passwords = {
      format = "yaml";
      key = "passwords";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
    wifi-environment = {
      format = "yaml";
      key = "environment";
      sopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/wifi.yaml;
    };
  };
}
