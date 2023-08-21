{ inputs, self
, config, lib, pkgs
, ...
}:
{
  networking.rxe = {
    enable = true;
    interfaces = [ "eth0" ];
  };

  imports = [
    #./firewall/iptables.nix
    #./firewall/nftables.nix
    #./managers/connman.nix
    #./managers/networkd.nix
    #./managers/networkmanager.nix
    #./wifi
    #./wifi/iwd.nix
    #./wifi/wpa_supplicant.nix
    #./wireguard/wg-quick.nix
    #./wireguard/peers/mullvad.nix
    #./wireguard/peers/eri1.nix
    #./wireguard/peers/nyc1.nix
    #./wireguard/peers/pit1.nix
    #./wireguard/peers/sea1.nix
    #./wireguard/peers/wdc1.nix
    #./resolvconf.nix
    #./rxe.nix
    #./sits.nix
    #./adblock.nix
    #./ucarp.nix
    #./vlans.nix
    #./vswitches.nix
  ];

  networking = {
    search = [ config.networking.domain
      "samlehman.me" "samlehman.dev"
      "lehman.run"
      "home.local"
    ];

    resolvconf = {
      package = pkgs.openresolv;
      dnsExtensionMechanism = true;  # Enable edns0 option in resolv.conf. When set, glibc supports extension machanisms for DNS (EDNS) specified in RFC 2671. (e.g. DNSSEC is extension & requires true)
      dnsSingleRequest = false;
      #extraConfig = ''
      #'';
      extraOptions = [];
      useLocalResolver = false;
    };

    stevenblack = {    # Host-based ad-block
      enable = true;
      block = [];      # fakenews | gambling | porn | social
    };

    tcpcrypt.enable = true;   # Enable opportunistic TCP encryption. If other end supports, then encrypt traffic, else cleartext.
    tempAddresses = "default";  # default=gen temp ipv6 addrs & use as source addrs in routing. enabled=gen temp ipv6 addrs, but still use EUI-64 addresses as source addresses

    #timeServers = [ "0.nixos.pool.ntp.org" "1.nixos.pool.ntp.org" "2.nixos.pool.ntp.org" "3.nixos.pool.ntp.org" ];

    useDHCP = true;
    useHostResolvConf = true;  # In containers, whether to use the resolv.conf supplied by the host
    useNetworkd = true;        # Whether to use networkd as network config backend or the legacy script based system.
    usePredictableInterfaceNames = true;

  };

  # TODO: Conditional based on system desktop environment
  environment.systemPackages = lib.mkIf config.services.xserver.gdm.enable [ pkgs.libnma-gtk4 ];

}
