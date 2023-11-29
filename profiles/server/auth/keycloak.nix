{ inputs
, config
, lib
, pkgs
, ...
}:
{
  inputs = [
    #./openldap.nix
    #../ngnix.nix
    #../database/postgresql.nix
  ];

  services.keycloak = {
    enable = true;
    package = pkgs.keycloak;
    plugins = [
      # In `pkgs.keycloak.plugins`
    ];
    themes = { };
    # TODO: sops-nix
    initialAdminPassword = "keycloak-${config.networking.domain}-${config.networking.hostName}-samlehman";
    database = rec {
      name = "keycloak";
      type = "postgresql"; # postgresql | mariadb | mysql
      createLocally = true;
      username = name;
      #useSSL = true;
      #port = if type == "postgresql" then 5432 else 3306;
      #host = "${type}.${config.networking.domain}";
      passwordFile = config.sops.secrets.server-keycloak-database-password.path;
      caCert = config.sops.secrets.server-keycloak-database-cacert.path;
    };
    settings = {
      hostname = "login.${config.networking.domain}";
      hostname-strict-backchannel = false;
      http-host = "0.0.0.0";
      http-port = 80;
      http-relative-path = "/"; # "/auth";
      https-port = 443;
      proxy = "passthrough"; # edge | reencrypt | passthrough | none
    };
    sslCertificate = config.sops.secrets.server-keycloak-ssl-certificate.path; #"/run/keys/ssl_cert";
    sslCertificateKey = config.sops.secrets.server-keycloak-ssl-certificate-key.path; #"/run/keys/ssl_key";
  };

  sops.secrets = {
    server-keycloak-initial-admin-password = { };
    server-keycloak-database-password = { };
    server-keycloak-database-cacert = { };
    server-keycloak-ssl-certificate = { };
    server-keycloak-ssl-certificate-key = { };
  };
}
