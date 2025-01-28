{
  config,
  pkgs,
  ...
}: {
  # https://github.com/majewsky/portunus#seeding-users-and-groups-from-static-configuration
  services.portunus = {
    enable = true;
    package = pkgs.portunus;
    domain = "portunus.${config.networking.domain}";
    port = 8080;
    group = "portunus";
    user = "portunus";
    dex = {
      enable = true;
      oidcclients = [
        {
          callbackURL = "";
          id = "";
        }
      ];
      port = 5556;
    };
    ldap = {
      package = pkgs.openldap.override {
        libxcrypt = pkgs.libxcrypt-legacy;
      };
      group = "openldap";
      user = "openldap";
      searchUserName = "admin";
      suffix = "dc=samlehman,dc=me";
      tls = true;
    };
    seedPath = "";
    stateDir = "/var/lib/portunus";
  };
}
