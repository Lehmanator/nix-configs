{ inputs, config, lib, pkgs, user, ... }: {
  imports = [
    inputs.self.nixosProfiles.firewall
    inputs.self.nixosProfiles.networkmanager
    inputs.self.nixosProfiles.resolvconf
    #inputs.self.nixosProfiles.rxe
    #inputs.self.nixosProfiles.sits
    #inputs.self.nixosProfiles.systemd-networkd
    #inputs.self.nixosProfiles.ucarp
    inputs.self.nixosProfiles.tailscale
    inputs.self.nixosProfiles.tailscale-mullvad-exit-node
    ./wireguard
    #./dns
    #./wifi

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
  hardware.wirelessRegulatoryDatabase =
    lib.mkDefault true; # Load regulatory DB at boot

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
  environment.systemPackages = with config.services.xserver;
    lib.mkIf (desktopManager.gnome.enable || displayManager.gdm.enable)
      [ pkgs.libnma-gtk4 ];

  # Enable opportunistic TCP encryption.
  #  If other end supports, then encrypt traffic, else cleartext.
  #  Note: Not reliable to ensure TCP encryption, but upgrades some insecure TCP
  # Problem: tcpcryptd crashes when attempting to change kernel settings via `sysctl` (kernel probably immutable)
  # TODO: Convert `iptables` rules to `nftables` in `systemd.services.tcpcrypt.prestart`
  # TODO: Drop `sysctl -w net.ipv4.tcp_ecn=0` in `systemd.services.tcpcrypt.prestart`?
  # TODO: Only enable `tcpcrypt` on interfaces without DNS over TLS/HTTPS/QUIC?
  #networking.tcpcrypt.enable = lib.mkDefault true;
  #users = with config.networking; {
  #  # Allow primary user to control networking without privilege escalation
  #  users.${user}.extraGroups = ["network" "tcpcryptd"] ++ lib.optional wireless.enable wireless.userControlled.group;
  #  users.tcpcryptd.group = "tcpcryptd";
  #  groups.tcpcryptd.members = lib.mkIf tcpcrypt.enable ["tcpcryptd" user ]; # Also create group
  #};
  users.users.${user}.extraGroups = [ "network" ];
  #boot.kernel.sysctl."net.ipv4.tcp_ecn" = 0; # d:2
}
