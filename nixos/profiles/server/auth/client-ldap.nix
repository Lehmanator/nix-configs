{ inputs
, config
, lib
, pkgs
, domain ? "samlehman.me"
, ...
}: {

  users.ldap = {
    enable = true;

    base = "dc=samlehman,dc=me";

    bind = {
      distinguishedName = "cn=admin,dc=samlehman,dc=me";
      passwordFile = "/run/secrets/ldap-bind.passwd";
      policy = "hard_open"; # hard_open | hard_init | soft
      timeLimit = 30;
    };

    daemon = {
      enable = true; # Use `nss-pam-ldapd` to handle LDAP lookups for NSS & PAM. Improves perf, may increase security.
      extraConfig = ''
      ''; # See nslcd.conf(5)
      rootpwmodddn = "cn=admin,dc=samlehman,dc=me";
      rootpwmodddnFile = "/run/secrets/ldap-root-pwmod.passwd";
    };

    # Not used if `users.ldap.daemon.enable = true`
    #extraConfig = ''
    #'';  # See `ldap.conf(5)

    loginPam = true;
    nsswitch = true;
    server = "ldaps://ldap.${domain}";
    #server = "ldap://ldap.${domain}";
    timeLimit = 0;
    useTLS = true; # Use TLS enc over LDAP (port 389) connection.

  };

}
