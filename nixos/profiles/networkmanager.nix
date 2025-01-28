{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  networking.networkmanager = {
    enable = lib.mkDefault true;
    enableStrongSwan = lib.mkDefault true;

    # List of nameservers that should be appended to ones configured in NetworkManager or received by DHCP.
    # appendNammeservers = [];

    # Configuration for [connection] section of NetworkManager.conf
    # See: https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    # connectionConfig = {
    #   lldp = "yes";
    #   llmnr = "no";
    #   mdns = "yes";
    #   mptcp-flags = "0x22";  # "enabled,subflow";
    #   dns-over-tls = "yes";
    #   ethernet.cloned-mac-address = "preserved";
    #   # 802-1x.auth-timeout =
    #   # autoconnect-slaves =
    #   # cdma.mtu =
    #   # connection.auth-retries = 3;
    #   # mud-url = "none";
    #   # stable-id = "";
    # };

    # Options: dhcpcd | internal
    # dhcp = "internal";

    dispatcherScripts = lib.mkDefault [
      {
        type = "basic";
        source = pkgs.writeText "upHook" ''
          if [ "$2" != "up" ]; then
            logger "exit: event $2 != up"
            exit
          fi
          logger "Device $DEVICE_IFACE coming up"
        '';
      }
    ];

    # Set resolv.conf DNS processing mode
    # See:
    # - https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    # - man NetworkManager.conf(5)
    # Options: default | dnsmasq | unbound | systemd-resolved | none
    # dns = "default";

    ensureProfiles.secrets.package = pkgs.nm-file-secret-agent;
    ensureProfiles.secrets.entries = [
      # { file = config.sops.secrets.wireguard-sea1-admin-privkey.path;
      #   key = "private-key";
      #   matchId = "wg-sea1";
      #   matchSetting = "wireguard";
      #   matchType = "wireguard";
      # }
    ];

    # https://networkmanager.dev/docs/api/latest/nm-settings-keyfile.html
    # https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/assembly_networkmanager-connection-profiles-in-keyfile-format_configuring-and-managing-networking
    # Conversion tool: https://github.com/janik-haag/nm2nix
    # `$ nix run git+https://github.com/janik-haag/nm2nix#nm2nix`
    ensureProfiles.profiles = {
    };

    ethernet.macAddress = lib.mkDefault "preserve";

    # List of name servers that should be inserted before the ones configured in NetworkManager or received by DHCP
    insertNameservers = [];
    logLevel = lib.mkDefault "WARN";
    plugins = lib.mkDefault [
      pkgs.networkmanager-fortisslvpn
      pkgs.networkmanager-iodine
      pkgs.networkmanager-l2tp
      pkgs.networkmanager-openconnect
      pkgs.networkmanager-openvpn
      pkgs.networkmanager-sstp
      pkgs.networkmanager-vpnc
    ];

    # Configuration added to the generated NetworkManager.conf.
    # - https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    # - man NetworkManager.conf(5)
    settings = {};

    # List of interfaces that will not be managed by NetworkManager
    # https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html#device-spec
    unmanaged = [];
  };

  # NetworkManager GTK4 lib
  environment.systemPackages = lib.mkIf config.services.xserver.desktopManager.gnome.enable [pkgs.libnma-gtk4];

  # Disable annoying failure on activation. TODO: Possible mitigations?
  # - Reorder deps? (after/before)
  # - Downgrade severity to warning?
  systemd.services.NetworkManager-wait-online.enable = lib.mkDefault false;

  # Allow users to configure NetworkManager
  users.users.${user}.extraGroups = ["networkmanager" "nm-openvpn"];
}
