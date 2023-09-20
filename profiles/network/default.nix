{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./dns
    ./firewall
    ./networkmanager.nix
    ./rxe.nix
    ./systemd-networkd.nix
    ./tailscale
    ./wifi
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

  networking = {
    tcpcrypt.enable = true; # Enable opportunistic TCP encryption. If other end supports, then encrypt traffic, else cleartext.
    tempAddresses = "default"; # default=gen temp ipv6 addrs & use as source addrs in routing. enabled=gen temp ipv6 addrs, but still use EUI-64 addresses as source addresses

    #timeServers = [ "0.nixos.pool.ntp.org" "1.nixos.pool.ntp.org" "2.nixos.pool.ntp.org" "3.nixos.pool.ntp.org" ];

    useDHCP = lib.mkDefault true;
    useHostResolvConf = !config.services.resolved.enable; # In containers, whether to use the resolv.conf supplied by the host
    usePredictableInterfaceNames = lib.mkDefault false; # Guarantees unique interface names like using `enp0s13f0u4u4u3` or `wlp166s0` instead of `wlan0` or `enp0s1` instead of `eth0`. Benefit is that unique names means that if devices are detected/added in inconsistent order, interface names don't get assigned to a different device between boots/rebuilds.

  };

  # TODO: Conditional based on system desktop environment
  environment.systemPackages = lib.mkIf (config.services.xserver.desktopManager.gnome.enable || config.services.xserver.displayManager.gdm.enable) [
    pkgs.libnma-gtk4
  ];

  users = lib.mkIf config.networking.tcpcrypt.enable {
    users.tcpcryptd.group = "tcpcryptd";
    groups.tcpcryptd = { };
  };

}
