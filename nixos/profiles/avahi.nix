{
  config,
  lib,
  pkgs,
  ...
}: {
  services.avahi = {
    enable = true;

    # List of network interfaces that should be used by avahi-daemon.
    #  Other interfaces ignored.
    #  If null, all local interfaces except loopback & point-to-point will be used.
    # - default: null
    allowInterfaces = null;

    # denyInterfaces = [ "" ];

    # WARN: Might make mDNS unreliable due to latencies w/ links & opens security hole by allowing mDNS access from internet connections
    # - default: false
    allowPointToPoint = false;

    # TODO: Use networking.search domains
    browseDomains = [
      "samlehman.me"
      "samlehman.dev"
      "lehman.run"
      config.networking.domain
    ];

    # default: 4096
    cacheEntriesMax = 8092;
    domainName = "local";

    # Enable mDNS NSS (Name Service Switch) plugin.
    # Allows apps to resolve .local domain by querying Avahi daemon
    # default: false
    nssmdns = true;

    openFirewall = true;

    publish = {
      # Enables publishing mDNS records in general
      # default: false
      enable = true;

      # Register mDNS records for all local IP addresses
      # default: false
      addresses = true;

      # Announce locally used domain name for browsing by other hosts
      # default=false
      domain = false;

      # Register mDNS HINFO record which contains info about local OS & CPU
      # default=false
      hinfo = false;

      # Publish user services. Sets addresses=true
      # default=false
      userServices = false;

      # Register service of type "_workstation._tcp" on local LAN
      # default=false
      workstation = false;
    };

    # Reflect incoming mDNS requests to all allowed network interfaces
    # default: false
    reflector = false;

    # Enable wide-area service discovery
    # default: true
    wideArea = true;

    # Extra config to append to avahi-daemon.conf
    # extraConfig = ''
    # '';

    extraServiceFiles = {
      ssh = lib.mkIf config.services.openssh.enable "${pkgs.avahi}/etc/avahi/services/ssh.service";
      smb = lib.mkIf config.services.samba.enable ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };

  # Avahi is incompatible w/ systemd-resolved
  services.resolved.enable = lib.mkForce false;
}
