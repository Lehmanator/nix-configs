{ inputs
, self
, config
, lib
, pkgs
, ...
}:
# See:
# - https://nixos.wiki/wiki/Systemd-resolved
# - https://www.freedesktop.org/software/systemd/man/systemd-resolved.html
# - systemd-resolved(8)
{
  imports = [
  ];

  networking.networkManager.dns = lib.mkDefault "systemd-resolved"; # man NetworkManager.conf(5)

  services.resolved = {
    enable = true;

    dnssec = "true"; # Options: *allow-downgrade | true | false
    llmnr = "true"; # true=full LLMNR responder/resolver support, false=disable-both, resolve=only-resolve+no-respond

    # Domains to search for hostnames
    domains = [
      "~."
    ] ++ config.networking.search;

    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one" # TODO: IPv6 of Cloudflare DNS
      #"9.9.9.9"                # TODO: IPv6 of Cloud9     DNS
    ];

    # Extra config to append to resolved.conf
    extraConfig = ''
      DNSOverTLS=yes
    '';

  };

  # Note: Avahi & systemd-resolved cannot be used simultaneously
  services.avahi.enable = false; #!config.services.resolved.enable;

}
