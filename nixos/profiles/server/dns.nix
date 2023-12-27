{ inputs
, config
, lib
, pkgs
, ...
}:
let
  website = "216.38.6.66";
  lan = "173.90.248.196";
  domain = "piwine.com";
  ms-dom = "piwine-com"; # TODO: Programmatic conversion from regular domain name
  ms-tenant = "piwines";

  piwine-com = with inputs.dns.lib.combinators; {
    SOA = {
      adminEmail = "webmaster@${domain}";
      expire = 10 * 24 * 60 * 60; # Time interval max that can elapse before the zone is no longer authoritative
      minimum = 60; # Minimum TTL field that should be exported with any RR from this zone
      nameServer = "ns.${domain}."; # The <domain-name> of the name server that was the original or primary source of data for this zone. Don't forget the dot at the end!
      refresh = 24 * 60 * 60; # Time interval before the zone should be refreshed. Default: 24h
      retry = 10 * 24 * 60 * 60; # Time interval that should elapse before a failed refresh should be retried.
      serial = 2023101800; # Version number of the original copy of the zone
    };
    NS = [
      "ns55.worldnic.com"
      "ns56.worldnic.com"
    ];
    A = [ website ];
    AAAA = [ ];
    CAA = [{
      issuerCritical = false;
      tag = "issue"; # issue | issuewild | iodef
      value = "ca.${domain}";
    }];
    DKIM = [{
      selector = "mail"; # DKIM selector name.
      h = [ "sha512" "sha256" "sha1" ]; # Acceptable hash algos. Empty implies all.
      k = "rsa"; # Encryption algo
      n = ""; # Arbitrary notes potential useful to humans.
      p = ""; # Public key in base64
      s = [ "*" ]; # Service type(s). Ex: "email"
      t = [ ]; # Flags. Ex: "y"
    }];
    DMARC = [{
      adkim = "strict";
      aspf = "strict";
      fo = "1";
      p = "quarantine";
      sp = "reject";
      pct = 100;
      rua = [ "mailto:webmaster@${domain}" "mailto:piwcadmin@gmail.com" ];
      ruf = [ "mailto:webmaster@${domain}" "mailto:piwcadmin@gmail.com" ];
    }];
    DNSKEY = [{
      flags = { zoneSigningKey = false; secureEntryPoint = false; };
      algorithm = "rsa";
      publicKey = ""; # Public key in base64
    }];
    DS = [{
      keyTag = 0; # u16: Tag computed over the DNSKEY referenced by this RR to identify it.
      algorithm = "rsa"; # algorithm of the key referenced by this RR
      digestType = "sha-256"; # Digest of the DNSKEY referenced by this RR
    }];
    MX = [{ exchange = "${ms-dom}.mail.protection.outlook.com"; preference = 0; }];
    PTR = [ ];
    SRV = [{
      service = ""; # Symbolic name of desired service. Dont add underscore.
      proto = ""; # Symbolic name of desired protocol. Dont add underscore.
      port = 22; # Port on this target host of this service.
      priority = 0; # Priority of this target host.
      target = ""; # Domain name of the target host.
      weight = 100; # Specifies relative weight for entries w/ same priority.
    }];
    TXT = [
      "MS=ms27247019" # Microsoft domain verification
      "v=spf1 ip4=${website} ip4=${lan} include:spf.protection.outlook.com -all" # SPF sender allow/deny list
      #"v=spf1 ip4=${website} ip4=${lan} include:spf.protection.outlook.com include:pi.wine -all" # SPF sender allow/deny list
    ];
    subdomains = {
      # Microsoft Outlook / Exchange & DKIM
      autodiscover.CNAME = [ "autodiscover.outlook.com" ];
      mail.CNAME = [ "${ms-dom}.mail.protection.outlook.com" ]; # SMTP/IMAP/POP3 host?
      imap.CNAME = [ "mail.${domain}" ]; # SMTP/IMAP/POP3 host?
      smtp.CNAME = [ "mail.${domain}" ]; # SMTP/IMAP/POP3 host?
      "selector1._domainkey".CNAME = [ "selector1-piwine-com._domainkey.${ms-tenant}.onmicrosoft.com" ]; # DKIM
      "selector2._domainkey".CNAME = [ "selector2-piwine-com._domainkey.${ms-tenant}.onmicrosoft.com" ]; # DKIM

      # Microsoft Teams / Skype for Business SIP calling
      lyncdiscover.CNAME = [ "webdir.online.lync.com" ];
      "_SIP._TLS".SRV = [ "sipdir.online.lync.com" ];
      "_SIPFEDERATIONTLS._TCP".SRV = [ "sipfed.online.lync.com" ];

      # Microsoft MLM / Intune / Device Management
      enterpriseregistration.CNAME = [ "enterpriseregistration.windows.net" ];
      enterpriseenrollment.CNAME = [ "enterpriseenrollment-s.manage.microsoft.com" ];

      # GitHub organization verification
      "_github-challenge-presqueislewinecellars-org".TXT = [ "8b9bbe0783" ];

      # Nameservers
      ns1.CNAME = [ "ns55.worldnic.com" ];
      ns2.CNAME = [ "ns56.worldnic.com" ];

      # Reroute www
      #www.A = [ "216.38.6.66" ];
      www.CNAME = [ domain ];

      # Reroute everything else to on-premises domain controller
      #"*".AAAA = [""]; TODO: Local network IPv6
      "*".A = [ lan ];
    };
  };
in
{
  imports = [
  ];


}
