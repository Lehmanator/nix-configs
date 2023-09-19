{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  networking.resolvconf = {
    package = pkgs.openresolv;

    dnsExtensionMechanism = true; # Enable edns0 option in resolv.conf. When set, glibc supports extension machanisms for DNS (EDNS) specified in RFC 2671. (e.g. DNSSEC is extension & requires true)
    dnsSingleRequest = false;

    #extraConfig = ''
    #'';

    #extraOptions = [
    #];

    #useLocalResolver = false;

  };

}
