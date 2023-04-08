{ self, inputs,
  config, lib, pkgs,
  host, network, repo,
  ...
}:
let
  tld = "me";
  domainPrefix = "samlehman";

in
{
  imports = [
    ../nginx.nix
  ];

  services.openldap = {
    enable = true;
    package = pkgs.openldap;

    user = "openldap";
    group = "openldap";
    mutableConfig = false;
    urlList = [ "ldap:///" "ldaps:///" ];

    settings = {
      attrs.olcLogLevel = [ "stats" ];
      includes = [];  # LDIF files to include after the parent's attributes but before its children
      children = {
        "cn=schema".includes = [
           "${pkgs.openldap}/etc/schema/core.ldif"
           "${pkgs.openldap}/etc/schema/cosine.ldif"
           "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
        ];
        "olcDatabase={-1}frontend" = {
          attrs = {
            objectClass = "olcDatabaseConfig";
            olcDatabase = "{-1}frontend";
            olcAccess = [ "{0}to * by dn.exact=uidNumber=0+gidNumber=0,cn=peercred,cn=external,cn=auth manage stop by * none stop" ];
          };
        };
        "olcDatabase={0}config" = {
          attrs = {
            objectClass = "olcDatabaseConfig";
            olcDatabase = "{0}config";
            olcAccess = [ "{0}to * by * none break" ];
          };
        };
        "olcDatabase={1}mdb" = {
          attrs = {
            objectClass = [ "olcDatabaseConfig" "olcMdbConfig" ];
            olcDatabase = "{1}mdb";
            olcDbDirectory = "/var/lib/openldap/ldap";
            olcDbIndex = [
              "objectClass eq"
              "cn pres,eq"
              "uid pres,eq"
              "sn pres,eq,subany"
            ];
            olcSuffix = "dc=example,dc=com";
            olcAccess = [ "{0}to * by * read break" ];
          };
        };
      };
    };

    declarativeContents = {
      "dc=${domainPrefix},dc=${tld}" = ''
        dn= dn: dc=${domainPrefix},dc=${tld}
        objectClass: domain
        dc: ${domainPrefix}

        dn: ou=users,dc=${domainPrefix},dc=${tld}
        objectClass = organizationalUnit
        ou: users
      '';
    };
  };
}
