# See:
# - https://nixos.wiki/wiki/Systemd-resolved
# - https://www.freedesktop.org/software/systemd/man/systemd-resolved.html
# - man systemd-resolved(8)
# - man NetworkManager.conf(5)

{ config, lib, pkgs, ... }: {
  networking.networkmanager.dns = lib.mkDefault "systemd-resolved";
  services.resolved = {
    enable = lib.mkDefault true;
    dnssec = "true";  # Options: *allow-downgrade | true | false
    llmnr = "true";   # true=full LLMNR responder/resolver support, false=disable-both, resolve=only-resolve+no-respond

    # Domains to search for hostnames
    domains = [
      "~."
    ] ++ config.networking.search;

    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one" # TODO: IPv6 of Cloudflare DNS
      #"9.9.9.9"                # TODO: IPv6 of Cloud9     DNS
      "192.168.1.1"
      "10.17.1.81"
      "127.0.0.1"
    ];

    # Extra config to append to resolved.conf
    extraConfig = ''
      DNSOverTLS=yes
    '';

  };

  # Note: Avahi & systemd-resolved cannot be used simultaneously
  services.avahi.enable = false; #!config.services.resolved.enable;
}
