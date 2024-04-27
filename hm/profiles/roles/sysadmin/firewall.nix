{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # Firewall Utils

  home.packages = [
    # --- CLI ---
    pkgs.iptables # Firewall old default (install for `iptables-translate` command & more to translate rules to nftables)

    # --- GUI ---
    pkgs.fwbuilder # GUI Firewall Management Application
    pkgs.shorewall # An IP gateway/firewall configuration tool for GNU/Linux
  ];
}
