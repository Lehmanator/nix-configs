{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  # --- TCPcrypt ---
  # Enable opportunistic TCP encryption.
  #  If other end supports, then encrypt traffic, else cleartext.
  #  Note: Not reliable to ensure TCP encryption, but upgrades some insecure TCP
  # Problem: tcpcryptd crashes when attempting to change kernel settings via `sysctl` (kernel probably immutable)
  # TODO: Convert `iptables` rules to `nftables` in `systemd.services.tcpcrypt.prestart`
  # TODO: Drop `sysctl -w net.ipv4.tcp_ecn=0` in `systemd.services.tcpcrypt.prestart`?
  # TODO: Only enable `tcpcrypt` on interfaces without DNS over TLS/HTTPS/QUIC?
  networking.tcpcrypt.enable = true;
  boot.kernel.sysctl."net.ipv4.tcp_ecn" = 0; # d:2
  users = {
    users.${user}.extraGroups = ["tcpcryptd"];
    users.tcpcryptd.group = "tcpcryptd";

    # Create tcpcryptd group
    groups.tcpcryptd.members = ["tcpcryptd"];
  };
}
