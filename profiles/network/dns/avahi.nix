{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  services.avahi = {
    enable = true;

    #allowInterfaces = null;   # default=null     List of network interfaces that should be used by avahi-daemon. Other interfaces ignored. If null, all local interfaces except loopback & point-to-point will be used.
    #denyInterfaces = [ "" ];  # default=null

    allowPointToPoint = false; # default=false   WARN: Might make mDNS unreliable due to latencies w/ links & opens security hole by allowing mDNS access from internet connections

    # TODO: Use networking.search domains
    browseDomains = [
      "samlehman.me"
      "samlehman.dev"
      "lehman.run"
    ];

    cacheEntriesMax = 8092;    # default=4096
    domainName = "local";      # default=local
    nssmdns = true;            # default=false   # Enable mDNS NSS (Name Service Switch) plugin. Allows apps to resolve .local domain by querying Avahi daemon
    openFirewall = true;       # default=true

    publish = {
      enable       = true;     # default=false  # Enables publishing mDNS records in general
      addresses    = true;     # default=false  # Register mDNS records for all local IP addresses
      domain       = false;    # default=false  # Announce locally used domain name for browsing by other hosts
      hinfo        = false;    # default=false  # Register mDNS HINFO record which contains info about local OS & CPU
      userServices = false;    # default=false  # Publish user services. Sets addresses=true
      workstation  = false;    # default=false  # Register service of type "_workstation._tcp" on local LAN
    };

    reflector = false;         # default=false  # Reflect incoming mDNS requests to all allowed network interfaces
    wideArea = true;           # default=true   # Enable wide-area service discovery

    # Extra config to append to avahi-daemon.conf
    #extraConfig = ''
    #'';

    # TODO: Only publish for enabled services
    extraServiceFiles = {
      #ssh = "${pkgs.avahi}/etc/avahi/services/ssh.service";
      #smb = ''
      #  <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
      #  <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      #  <service-group>
      #    <name replace-wildcards="yes">%h</name>
      #    <service>
      #      <type>_smb._tcp</type>
      #      <port>445</port>
      #    </service>
      #  </service-group>
      #'';
    };

  };

  # Avahi is incompatible w/ systemd-resolved
  services.resolved.enable = false;

}
