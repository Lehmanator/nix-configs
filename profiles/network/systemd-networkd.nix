{ inputs
, self
, config
, lib
, pkgs
, ...
}:
# See:
# - https://nixos.wiki/wiki/Systemd-networkd
# - https://nixos.wiki/wiki/WireGuard#Setting_up_WireGuard_with_systemd-networkd
# - https://www.freedesktop.org/software/systemd/man/systemd-networkd.html
# - https://www.freedesktop.org/software/systemd/man/systemd.netdev.html
# - https://www.freedesktop.org/software/systemd/man/systemd.network.html
# - https://www.freedesktop.org/software/systemd/man/systemd.link.html
# - https://www.freedesktop.org/software/systemd/man/systemd.network.html#RequiredForOnline=
# - https://www.freedesktop.org/software/systemd/man/networkctl.html#%0A%20%20%20%20%20%20%20%20%20%20list%0A%20%20%20%20%20%20%20%20%20%20PATTERN%E2%80%A6%0A%20%20%20%20%20%20%20%20
# - https://systemd.io/NETWORK_ONLINE/
#
# Note: Both systemd-networkd & NetworkManager can exist in parallel on the same machine
#       when they manage a distinct set of interfaces
#
#   Use systemd-networkd for:
#   - servers
#   - routers
#   - always-on VPN tunnels
#
#  Use NetworkManager for:
#   - Varying WLAN profiles
#   - Selectively-enabled VPN tunnels
#
# Note: Option `networking.useNetworkd` will translate some of `networking.interfaces` & networking.useDHCP` into networkd.
#       Avoid using if you can write complete network setup in native networkd configuration.
{
  imports = [
  ];

  networking.useDHCP = true;
  networking.useNetworkd = true; # Use systemd-networkd as network config backend or legacy script based system

  systemd.network = {
    enable = true;

    # Network Devices
    netdevs = { };

    # Networks
    networks = { };

  };

}
