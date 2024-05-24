{ inputs, config, lib, pkgs, ... }: {
  imports = [
    #inputs.self.nixosProfiles.resolvconf
    #inputs.self.nixosProfiles.systemd-resolved
    #./adblock.nix
    #./encrypted.nix
    #./avahi.nix     # Incompatible w/ systemd-resolved
  ];

  networking = {
    # Upstream DNS nameservers to resolve domain names & hostnames
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      #"9.9.9.9"
    ];

    # Domains to search for hostnames
    search = [ "samlehman.me" "samlehman.dev" "lehman.run" "home.local" ]
      ++ lib.optional (config.networking.domain != null)
      config.networking.domain;
  };
}
