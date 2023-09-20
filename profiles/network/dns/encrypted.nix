{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # Without systemd-resolved
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    dhcpcd.extraConfig = lib.mkIf config.networking.dhcpcd.enable "nohook resolv.conf";
    networkmanager.dns = lib.mkIf config.networking.networkmanager.enable "none";
  };
  services.resolved.enable = false;

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "...";
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      #server_names = [ ... ];
    };
  };
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
