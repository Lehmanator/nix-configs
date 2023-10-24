{ inputs
, self
, config
, lib
, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    #./dns
    ./dns/resolvconf.nix
    ./firewall.nix
    ./networkmanager.nix
    #./rxe.nix
    #./systemd-networkd.nix
    ./tailscale
    #./wifi
    ./wireguard
    #./sits.nix
    #./ucarp.nix

    #./managers/connman.nix
    #./managers/networkd.nix
    #./managers/networkmanager.nix
    #./wifi/iwd.nix
    #./wifi/wpa_supplicant.nix
    #./wireguard/wg-quick.nix
    #./wireguard/peers/mullvad.nix
    #./wireguard/peers/eri1.nix
    #./wireguard/peers/nyc1.nix
    #./wireguard/peers/pit1.nix
    #./wireguard/peers/sea1.nix
    #./wireguard/peers/wdc1.nix
    #./vlans.nix
    #./vswitches.nix
  ];

  # Load regulatory DB at boot
  hardware.wirelessRegulatoryDatabase = true;

  networking = {
    # IPv6 <-> IPv4 address generation & translation
    # default=gen temp ipv6 addrs & use as source addrs in routing.
    # enabled=gen temp ipv6 addrs, but still use EUI-64 addresses as source addresses
    tempAddresses = lib.mkDefault "default";

    #timeServers = [ "0.nixos.pool.ntp.org" "1.nixos.pool.ntp.org" "2.nixos.pool.ntp.org" "3.nixos.pool.ntp.org" ];
    # DHCP - Dynamically assign IP addresses
    useDHCP = lib.mkDefault true;

    # In containers, whether to use the `/etc/resolv.conf` supplied by the host
    #  Note: Some reason why you may want to disable this, but cant remember why
    useHostResolvConf = !config.services.resolved.enable;

    # Guarantees unique interface names.
    #  e.g. naming `eth0` -> `enp0s13f0u4u4u3` or `wlan0` -> `wlp166s0` instead of `wlan0` / `enp0s1` instead of `eth0`.
    #  Benefit is that unique names means that if devices are detected/added in inconsistent order,
    #   interface names don't get assigned to a different device between boots/rebuilds.
    usePredictableInterfaceNames = lib.mkDefault false;

  };

  # NetworkManager GTK4 lib
  # TODO: Conditional based on system desktop environment
  environment.systemPackages = with config.services.xserver; lib.mkIf (desktopManager.gnome.enable || displayManager.gdm.enable) [
    pkgs.libnma-gtk4
  ];

  # Enable opportunistic TCP encryption.
  #  If other end supports, then encrypt traffic, else cleartext.
  #  Note: Not reliable to ensure TCP encryption, but upgrades some insecure TCP
  networking.tcpcrypt.enable = true;
  #users = lib.mkIf config.networking.tcpcrypt.enable {
    # Also create group
    users.groups.tcpcryptd = { };
    users.users.tcpcryptd.group = "tcpcryptd";
    #users.users.${user}.extraGroups = [ "tcpcryptd" ];
  #};

  # Allow primary user to control networking without privilege escalation
  users.users."${user}".extraGroups = [ "network" ]
    ++ lib.optional config.networking.tcpcrypt.enable "tcpcryptd"
    ++ lib.optional config.networking.wireless.enable config.networking.wireless.userControlled.group;
}
