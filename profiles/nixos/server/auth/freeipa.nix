{ inputs, config, lib, pkgs
, domain ? "samlehman.me"
, ...
}: {
  imports = [
  ];

  # --- Homepage & Docs ---
  # https://www.freeipa.org/page/Deployment_Recommendations
  # https://www.freeipa.org/page/Web_UI

  # --- Git Repos ---
  # https://github.com/orgs/freeipa/repositories
  # https://github.com/freeipa
  # https://github.com/freeipa/freeipa-webui
  # https://github.com/freeipa/freeipa
  # https://github.com/freeipa/freeipa-kustomize
  # https://github.com/freeipa/freeipa-operator
  # https://github.com/freeipa/freeipa-openshift

  # --- Helm Charts ---
  # https://artifacthub.io/packages/helm/redhat-cop/ipa
  # https://artifacthub.io/packages/helm/improwised/freeipa
  # https://artifacthub.io/packages/helm/cocainefarm/freeipa-self-service

  # FreeIPA Includes:
  # - LDAP: [389 Directory Server](http://directory.fedoraproject.org/wiki/Main_Page)
  # - SSO Authentication: [MIT Kerberos](http://en.wikipedia.org/wiki/Kerberos_%28protocol%29)
  # - Certificate Authority: [Dogtag](http://pki.fedoraproject.org/wiki/PKI_Main_Page)
  # - Domain Name Management: [ISC Bind](https://www.isc.org/software/bind)
  # - RedHat Network Administration tools for access control, delegation, etc.
  # - UI: Web UI or CLI

  # Integrates Linux client or is this a FreeIPA server?
  # - Linux Client Auth via [SSSD](https://sssd.io/)
  security.ipa = {
    inherit domain;
    basedn = "dc=samlehman,dc=me";
    cacheCredentials = true;
    certificate = pkgs.fetchurl { url = "https://ipa.${domain}/ipa/config/ca.crt"; sha256 = ""; };
    chromiumSupport = true;
    dyndns.enable = true;
    dyndns.interface = "*"; #"eth0";
    ifpAllowedUids = [   # List of users allowed to access the ifp dbus interface
      "root"
    ];
    offlinePasswords = true;
    realm = lib.strings.toUpper domain;  # Kerberos realm
    server = "ipa.${domain}";

  };

}
