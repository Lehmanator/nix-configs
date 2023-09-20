{ ... }: {

  services.sssd = {
    environmentFile = ""; # systemd.exec(5)
      ## snippet of sssd-related config
      #[domain/LDAP]
      #ldap_default_authtok = $SSSD_LDAP_DEFAULT_AUTHTOK
      #
      ## contents of the environment file
      #SSSD_LDAP_DEFAULT_AUTHTOK=verysecretpassword



  };

}
