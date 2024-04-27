{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./adblock.nix
    #./encrypted.nix
    #./avahi.nix     # Incompatible w/ systemd-resolved
    ./resolvconf.nix
    ./resolved.nix
  ];

  networking = {

    # Upstream DNS nameservers to resolve domain names & hostnames
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      #"9.9.9.9"
    ];

    # Domains to search for hostnames
    search = [
      config.networking.domain
      "samlehman.me"
      "samlehman.dev"
      "lehman.run"
      "home.local"
    ];

  };

}
