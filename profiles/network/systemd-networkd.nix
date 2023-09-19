{ inputs, self
, config, lib, pkgs
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
  # Note: There is also ../boot/systmed-networkd.nix for configuring systemd networks in initram
  #  ../boot/systemd-networkd.nix also should import ../boot/systemd-initrd.nix & ../boot/systemd.nix
  imports = [
  ];

  networking = {
    useNetworkd = true;
    useDHCP = true;
    interfaces = {
      #<name> = { ipv4.routes = [{address="192.168.2.0"; prefixLength=24; via="192.168.1.1";}]; };
    };
    dhcpcd.enable = false;  # Disable because networkd handles DHCP now.
  };

  systemd.network = {
    enable = true;
    wait-online = {
      enable = true;
      extraArgs = []; # Extra CLI args to pass to `systemd-networkd-wait-online`. Also affects per-interface services.
    };

    #config = {
    #
    #  # Corresponds to options in `[Network]` section of the networkd config. See: `networkd.conf(5)`
    #  networkConfig = {
    #    ManageForeignRoutingPolicyRules = false;
    #    SpeedMeter = true;
    #  };
    #
    #  # Corresponds to options in `[DHCPv4]` section of the networkd config. See: `networkd.conf(5)`
    #  dhcpV4Config = {
    #    DUIDType = "vendor";
    #  };
    #
    #  # Corresponds to options in `[DHCPv6]` section of the networkd config. See: `networkd.conf(5)`
    #  dhcpV6Config = {
    #  };
    #
    #  # Defines route table names as an attrset of name to number. See: `networkd.conf(5)`
    #  routeTables = {
    #    #foo = 27;
    #  };
    #};

    # Network Devices
    #netdevs = {
    #};

    # Networks
    #networks = {
    #};

    #links = {
    #  #<name>.enable = true;  # Enables .link unit. Handled by udev.
    #};
  };

  # Service to handle systemd-networkd connection status change. See: https://gitlab.com/craftyguy/networkd-dispatcher
  #services.networkd-dispatcher = {
  #  enable = true;
  #  rules = {
  #    "restart-tor" = {
  #      onState = ["routable" "off"];
  #      script = ''
  #        #!${pkgs.runtimeShell}
  #        if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
  #          echo "Restarting Tor ..."
  #          systemctl restart tor
  #        fi
  #        exit 0
  #      '';
  #    };
  #  };
  #};

}
