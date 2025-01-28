{
  inputs,
  config,
  lib,
  ...
}:
# TODO: Create lib to automatically create for each service:
# - TODO: DNS entries
# - TODO: Theme config (nix-colors | stylix)
# - TODO: Service Accounts for backend programs
#   - TODO: Unix:      user, group,
#   - TODO: Auth:      LDAP, Keycloak, Hashicorp Vault
#     - Fields: client_id, client_secret, service_account_name, service_account_password
#   - TODO: Database:  mysql, postgresql, mongodb, sqlite3
#     - Fields: username, database name, password file secret
#   - TODO: Cache:     redis, memcached
#     - Fields: username, database name, password file secret
#   - TODO: Storage:   minio, host filesystem,
#     - Fields: bucket, encryption_key
#   - TODO: Reverse Proxy: NGINX, Apache, Traefik,
#     - Fields: Virtual host, SSL certs, ingress, port-mapping,
#   - TODO: Mailing:   maingun,
{
  imports = [inputs.firefly.nixosModules.firefly-iii];
  services.firefly-iii = {
    enable = true;
    hostname = "firefly.${config.networking.hostName}";
    appURL = "https://firefly.${config.networking.fqdn}";
    appKeyFile = config.age.secrets."firefly-appkey".path;
    dataDir = "/var/lib/firefly";
    group = "nginx";
    nginx = {
      enableACME = config.security.acme.acceptTerms;
      forceSSL = config.security.acme.acceptTerms;
      serverAliases = [
        "firefly"
        "firefly.local"
        "firefly.lan"
        "firefly.${config.networking.hostName}"
        "firefly.${config.networking.fqdn}"
      ];
    };
    poolConfig = {
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
    };
    config = {
      MAILGUN_SECRET = {_secret = config.age.secrets."firefly-serviceaccount-mailgun".path;};
    };
    database = rec {
      name = "firefly";
      createLocally = lib.mkDefault false;
      type =
        if config.services.postgresql.enable
        then "pgsql"
        else "mysql";
      host =
        if createLocally
        then "localhost"
        else "${type}.${config.networking.domain}";
      port =
        if config.services.postgresql.enable
        then 5432
        else 3306;
      passwordFile = config.age.secrets."firefly-serviceaccount-${type}".path;
    };
  };

  nix.settings = {
    substituters = ["https://timhae-firefly.cachix.org/"];
    trusted-public-keys = ["timhae-firefly.cachix.org-1:TMexYUvP5SKkeKG11WDbYUVLh/4dqvCqSE/c028sqis="];
  };

  age.secrets.firefly-appkey = {
    file = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/firefly-appkey.age;
    mode = "770";
    owner = "firefly-iii";
    group = "nginx";
  };
}
