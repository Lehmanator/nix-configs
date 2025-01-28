{
  inputs,
  config,
  lib,
  user,
  ...
}: let
  mkLan = hn: lib.map (tld: "${hn}.${tld}") ["local" "lan"];
in {
  imports = [(inputs.self + /nixos/profiles/wifi)];

  # Load regulatory DB at boot
  hardware.wirelessRegulatoryDatabase = lib.mkDefault true;

  # IPv6 <-> IPv4 address generation & translation
  # default=gen temp ipv6 addrs & use as source addrs in routing.
  # enabled=gen temp ipv6 addrs, but still use EUI-64 addresses as source addresses
  networking.tempAddresses = lib.mkDefault "default";

  # timeServers = [ "0.nixos.pool.ntp.org" "1.nixos.pool.ntp.org" "2.nixos.pool.ntp.org" "3.nixos.pool.ntp.org" ];
  # DHCP - Dynamically assign IP addresses
  networking.useDHCP = lib.mkDefault true;

  # In containers, whether to use the `/etc/resolv.conf` supplied by the host
  #  Note: Some reason why you may want to disable this, but cant remember why
  networking.useHostResolvConf = !config.services.resolved.enable;

  # Guarantees unique interface names.
  #  e.g. naming `eth0` -> `enp0s13f0u4u4u3` or `wlan0` -> `wlp166s0` instead of `wlan0` / `enp0s1` instead of `eth0`.
  #  Benefit is that unique names means that if devices are detected/added in inconsistent order,
  #   interface names don't get assigned to a different device between boots/rebuilds.
  networking.usePredictableInterfaceNames = lib.mkDefault false;

  # Upstream DNS nameservers to resolve domain names & hostnames
  networking.nameservers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
    #"9.9.9.9"
  ];

  # Domains to search for hostnames
  networking.search = [
    config.networking.domain
    "samlehman.dev"
    "samlehman.me"
    "home.local"
  ];

  networking.hosts = {
    # --- Home Network ---
    "192.168.1.1" = mkLan "router";
    "192.168.1.2" = mkLan "wyse";
    "192.168.1.6" = mkLan "cheetah";
    "192.168.1.20" = mkLan "nintendo";
    "192.168.1.30" = mkLan "fw";
    "192.168.1.100" = mkLan "flame";
  };

  users.users.${user}.extraGroups = ["network"];
}
