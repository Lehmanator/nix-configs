{ self
, inputs
, system ? "x86_64-linux"
, host
, network
, repo
, config
, lib
, pkgs
,
}:
let
  secretsDir = if host ? "dirs.secrets" then host.dirs.secrets else "/run/secrets";
in
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

    initialAdminPassword = "keycloak-${config.networking.domain}-${config.networking.host}-samlehman";

    database = rec {
      name = "keycloak";
      type = "postgresql"; # postgresql | mariadb | mysql
      createLocally = true;

      username = name;
      #useSSL = true;
      #port = if type == "postgresql" then 5432 else 3306;
      #host = "${type}.${config.networking.domain}";
      passwordFile = "${secretsDir}/keycloak-database-${type}.passwd";
      caCert = "/run/certs/keycloak-${type}-certificate-authority.cert";
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

    sslCertificate = "/run/keys/ssl_cert";
    sslCertificateKey = "/run/keys/ssl_key";

  };
}
