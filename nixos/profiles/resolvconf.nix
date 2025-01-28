{ config, lib, pkgs, ... }: {
  networking.resolvconf = {
    #useLocalResolver = false;
    #package = lib.mkDefault pkgs.openresolv;
    dnsExtensionMechanism = true; # Enable edns0 option in resolv.conf. When set, glibc supports extension machanisms for DNS (EDNS) specified in RFC 2671. (e.g. DNSSEC is extension & requires true)
    dnsSingleRequest = false; # Recent versions of glibc will issue both IPv4 (A) & IPv6 (AAAA) address queries at the same time from the same port. Sometimes upstream routers will systematically drop the IPv4 queries. This option specifies the option `single-request` in `/etc/resolv.conf`.
    #extraConfig = ''
    #'';
    #extraOptions = [];
  };
}
