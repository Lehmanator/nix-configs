{
  inputs,
  config,
  lib,
  pkgs,
  host ? "samlehman.me",
  ...
}: {
  imports = [
  ];

  # https://github.com/lldap/lldap
  # https://github.com/lldap/lldap/blob/main/example_configs
  # https://github.com/Evantage-WS/lldap-kubernetes

  services.lldap = {
    enable = true;
    environment = {
      # Config options prefix w/ `LLDAP_` take priority over config file.
      LLDAP_JWT_SECRET_FILE = "/run/lldap/jwt_secret";
      LLDAP_LDAP_USER_PASS_FILE = "/run/lldap/user_password";
    };
    environmentFile = null; # Environment file as defined in `systemd.exec(5)` passed to service.
    package = pkgs.lldap;

    # https://github.com/lldap/lldap/blob/main/lldap_config.docker_template.toml
    settings = rec {
      # Settings written to `lldap_config.toml`
      database_url = "sqlite://./users.db?mode=rwc"; # "postgres://pg-user:password@pg-server/my-database"
                                                     # "mysql://mysql-user:password@mysql-server/my-database"
      http_host = "::";
      http_port = 17170;
      http_url = "http://localhost";
      ldap_base_dn = "dc=samlehman,dc=me";
      ldap_host = "::";
      ldap_port = 3890;
      ldap_user_dn = "admin";
      ldap_user_email = "${ldap_user_dn}@${host}";
      bindDn = "cn=admin,${ldap_base_dn}";
      bindPasswordFile = "/run/secrets/lldap-password-binddn.passwd";

      # --- No explicit NixOS options ------------------------
      verbose = false;
      ignored_user_attributes = [ "sAMAccountName" ];
      ignored_group_attributes = [ "mail" "userPrincipalName" ];

      # --- Secrets ---
      jwt_secret = "<replace_with_random>"; # Gen with: LC_ALL=C tr -dc 'A-Za-z0-9!#%&'\''()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c 32; echo ''
      key_file = "/data/private_key";
      key_seed = "<random_string>";
      ldap_user_pass = "<replace_with_passwd>";

      smtp_options = {
        enable_password_reset = true;
        server = "mail-next.617a.net";
        port = 587;  # SMTP port
        smtp_encryption = "TLS";
        user = "me@${host}";
        password = "";
        from = "Accounts <accounts@${host}>";
        reply_to = "Do Not Reply <noreply@${host}>";
      };

      ldaps_options = {
        enabled = true;
        port = 6360;
        cert_file = "/data/cert.pem";
        key_file = "/data/key.pem";
      };

    };

  };

  #services.mailman.ldap.attrMap = {
  #  email = "mail";
  #  firstName = "givenName";
  #  lastName = "sn";
  #  username = "uid";
  #};

}
