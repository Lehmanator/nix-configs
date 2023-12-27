{ inputs
, config
, lib
, pkgs
, ...
}:
{
  services.sssd = {
    enable = true;

    # Contents of `sssd.conf`
    config = ''
      [sssd]
      config_file_version = 2
      services = nss, pam
      domains = shadowutils

      [nss]

      [pam]

      [domain/shadowutils]
      id_provider = proxy
      proxy_lib_name = files
      auth_provider = proxy
      proxy_pam_target = sssd-shadowutils
      proxy_fast_alias = True
    '';

    # --- Config Snippet ---
    #[domain/LDAP]
    #ldap_default_authtok = $SSSD_LDAP_DEFAULT_AUTHTOK
    # --- Env File Content ---
    #SSSD_LDAP_DEFAULT_AUTHTOK=verysecretpassword
    environmentFile = "/run/secrets/sssd.env"; #"/etc/sssd.env";

    kcm = true; # SSS as Kerberos Cache Manager (KCM)

    sshAuthorizedKeysIntegration = true; # Makes sshd lookup authorized keys from SSS. To work, the `ssh` SSS service must be enabled in the sssd configuration.

  };

  #security.pam.services."NAME".sssdStrictAccess = true;  # Enforce SSSD access control

}
