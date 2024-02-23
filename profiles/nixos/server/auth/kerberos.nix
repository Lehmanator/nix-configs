{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  services.kerberos_server = {
    enable = true;
    realms = {
      personal = {
        principal = "SAMLEHMAN.me";
        acl = [
          { access = ""; principal = ""; target = ""; }
        ];
      };
      piwc = {
        principal = "PIWINE.com";
        acl = [
          { access = ""; principal = ""; target = ""; }
        ];
      };
      piwine = {
        principal = "PI.wine";
        acl = [
        ];
      };

    };

  };



  # --- Kerberos Client ---
  krb5 = {
    enable = true;
    kerberos = pkgs.krb5; # pkgs.heimdall;

    appdefaults = {
      pam = {
        debug = false;
        ticket_lifetime = 36000;
        renew_lifetime = 36000;
        max_timeout = 30;
        timeout_shift = 2;
        initial_timeout = 1;
      };
    };
    domain_realm = {
      "pi.wine" = "PI.WINE";
      "piwine.com" = "PIWINE.COM";
      "pi.local" = "PI.LOCAL";
      "samlehman.me" = "SAMLEHMAN.ME";
      "samlehman.dev" = "SAMLEHMAN.DEV";
      "redstone.pw" = "REDSTONE.PW";
    };

    capaths = {
      "PIWINE.COM" = {
        "PI.WINE" = ".";
        "PI.LOCAL" = ".";
      };
      "PI.WINE" = {
        "PIWINE.COM" = ".";
        "PI.LOCAL" = ".";
      };
      "PI.LOCAL" = {
        "PIWINE.COM" = ".";
        "PI.WINE" = ".";
      };
    };

    #config = { };  # Mutually exclusive with other options. See `man krb5.conf`
    extraConfig = ''
      [logging]
        kdc          = SYSLOG:NOTICE
        admin_server = SYSLOG:NOTICE
        default      = SYSLOG:NOTICE
    '';   # Appended verbatim to `krb5.conf`, may include any valid relations for `kdc.conf`. See: man kdc.conf

    libdefaults = {
      default_realm = "PI.WINE";
    };

    plugins = {
      ccselect = {
        #disable = "k5identity";
      };
    };

    realms = {
      "PI.WINE" = {
        admin_server = "pi.wine";
        kdc = [
          "kdc01.pi.wine"
          "kdc02.pi.wine"
        ];
      };
      "PIWINE.COM" = {
      };
      "PI.LOCAL" = {
      };
      "SAMLEHMAN.ME" = {
      };
      "SAMLEHMAN.DEV" = {
      };
      "REDSTONE.PW" = {
      };
    };

  };

  security.pam.krb5.enable = true;  # Enables Kerberos PAM modules (pam-krb5, pam-ccreds)

}

