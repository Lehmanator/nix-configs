{ inputs, self
, config, lib, pkgs
, ...
}:
{

  # See:
  # - https://nixos.wiki/wiki/Systemd-networkd
  # - https://nixos.wiki/wiki/WireGuard#Setting_up_WireGuard_with_systemd-networkd
  # - https://www.freedesktop.org/software/systemd/man/systemd-networkd.html
  # - https://www.freedesktop.org/software/systemd/man/systemd.netdev.html
  # - https://www.freedesktop.org/software/systemd/man/systemd.network.html
  # - https://www.freedesktop.org/software/systemd/man/systemd.link.html
  # - https://www.freedesktop.org/software/systemd/man/systemd.network.html#RequiredForOnline=
  # - https://www.freedesktop.org/software/systemd/man/networkctl.html
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

  imports = [
  ];

  networking.useNetworkd = true;
  networking.useDHCP = lib.mkDefault true;

  #systemd.network = {
  #  enable = true;
  #
  #  # Links - Reconfigures existing network Devices
  #  # - Note: Actually implemented by udev, not systemd-networkd
  #  # - Note: Executed by udev & only applied on boot
  #  # - Docs: https://www.freedesktop.org/software/systemd/man/systemd.link.html
  #  #links = {
  #  #};
  #
  #  # Network Devices - Creates virtual network devices
  #  # - Note: Doesnt modify properties (e.g. MTU, VLAN ID, VXLAN ID, Wireguard Peers) of existing netdevs
  #  # - Docs: https://www.freedesktop.org/software/systemd/man/systemd.netdev.html
  #  #netdevs = {
  #  #};
  #
  #  # Networks - Configures network devices
  #  # - Docs: https://www.freedesktop.org/software/systemd/man/systemd.network.html
  #  #networks = {
  #  #};
  #
  #};

}
