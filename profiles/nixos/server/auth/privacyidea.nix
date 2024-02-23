{ inputs
, lib
, pkgs
, config
, domain ? "samlehman.me"
, ...
}:
{
  imports = [
  ];

  services.privacyidea = {
    enable = true;

    adminEmail = "admin@${domain}";
    adminPasswordFile = "/run/secrets/privacyidea-admin.passwd";
    auditKeyPrivate = "";
    auditKeyPublic = "";
    encFile = "";
    environmentFile = "";
    extraConfig = ''
    '';

    group = "";
    user = "";

    ldap-proxy = {
      enable = true;
      configFile = "";
      environmentFile = "";
      group = "";
      user = "";
      settings = { };
    };
    pepper = { };

    secretKey = "";
    stateDir = "";
    superuserRealm = "";

    tokenjanitor = {
      enable = true;
      action = "";
      interval = "";
      orphaned = "";
      unassigned = "";
    };

  };

}
