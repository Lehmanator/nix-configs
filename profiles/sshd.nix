{ config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- SSHD ---------------------------------------------------------
  services.openssh = {
    enable = true;
    startWhenNeeded = true;   # If set, SSHD is socket-activated, w/ systemd starting an instance for each incoming connection instead of running permanently as a daemon.

    # --- Host Keys ---
    hostKeys = [ { type = "rsa";     bits = 4096; path = "/etc/ssh/ssh_host_rsa_key";     openSSHFormat = true; rounds = 100; }
                 { type = "ed25519";              path = "/etc/ssh/ssh_host_ed25519_key";                                     }
    ];
    # --- Remote Hosts ---
    knownHosts = {
      wyse = { publicKeyFile = "/etc/ssh/hosts/wyse.pub";
               hostNames = [ "wyse" "192.168.1.2" "wyse.local" "wyse.lan" "wyse.wan" "wyse.home"
                "wyse.piwine.com" "wyse.lehman.run"                                                   ];
      };
      cheetah = { publicKeyFile = "/etc/ssh/hosts/cheetah.pub";
        hostNames = [ "cheetah"            "192.168.1.101"      "10.17.1.201"
                      "cheetah.local"      "cheetah.lan"        "cheetah.wan"          "cheetah.home"
                      "cheetah.piwine.com" "cheetah.lehman.run" "cheetah.samlehman.me"                ];
      };
    };
    # --- Networking ---
    listenAddresses = [ { addr = "192.168.3.1"; port = 22;   }
                        { addr = "0.0.0.0";     port = 2223; } ];
    openFirewall = true;
    ports = [ 2223 ];

    settings = {
      GatewayPorts = "no";                 # Whether remote hosts allowed to connect to ports forwarded for client. sshd_config(5)
      KbdInteractiveAuthentication = true; # Whether keyboard-interactive authentication is allowed.
      PasswordAuthentication = false;      # (Dis)allow auth using passwords
      PermitRootLogin = "no";              # yes | without-password | prohibit-password | forced-commands-only | no
      UseDns = true;                       # Lookup remote host name & check that resolved host name for remote IP maps to same IP.
      X11Forwarding = true;                # (Dis)allow X11 connections to be forwarded.
      #LogLevel = "INFO";                   # QUIET | FATAL | ERROR | INFO | VERBOSE | DEBUG | DEBUG1 | DEBUG2 | DEBUG3
      # --- Crypto Algorithms ---
      #Ciphers = [ "chacha20-poly1305@openssh.com" "aes256-gcm@openssh.com" "aes128-gcm@openssh.com" "aes256-ctr"             "aes192-ctr"             "aes128-ctr" ];
      #KexAlgorithms = [ "sntrup761x25519-sha512@openssh.com" "curve25519-sha256" "curve25519-sha256@libssh.org" "diffie-hellman-group-exchange-sha256" ];
      #Macs = [ "hmac-sha2-512-etm@openssh.com" "hmac-sha2-256-etm@openssh.com" "umac-128-etm@openssh.com" ];
    };
    # --- SFTP ---
    allowSFTP = true;
    #sftpFlags = [ "-f AUTHPRIV" "-l INFO:" ];
    #sftpServerExecutable = "internal-sftp";

    # --- Misc ---
    #authorizedKeysCommand = "none";
    #authorizedKeysCommandUser = "nobody";
    #authorizedKeysFiles = [];
    #banner = null;
    #moduliFile = "/etc/ssh/my-moduli"; # Installed to /etc/ssh/moduli, OpenSSH default if null.
    #extraConfig = ''
    #'';
  };
  networking.dhcpcd.persistent = true;  # Set true if machine accepts SSH connections thru DHCP interfaces & clients should be notified when it shuts down.

  # --- SSH Security -------------------------------------------------
  # --- sshguard ---
  services.sshguard = {         # Service to block IP addresses attempting SSH brute force attacks.
    enable = true;              # Enable sshguard service
    #attack_threshold = 30;     # Block attacker after cumulative attack score exceeds threshold. Most attacks' scores = 10
    blacklist_file = "/var/lib/sshguard/blacklist.db";
    blacklist_threshold = 120;  # Blacklist attacker after score exceeds threshold.
    blocktime = 120;            # Seconds to block attacker after exceeding threshold. Each subsequent block inc by 1.5x
    detection_time = 1000;      # Remember potential attackers for up to this many seconds before resetting score.
    services = [ "sshd"
      #"cockpit" "exim" "dovecot" "cucipop" "uwimap" "vsftpd" "postfix" "proftpd" "pure-ftpd"
    ];                          # systemd services sshguard should receive logs from.
    whitelist = [ ];
  };

  # --- endlessh ---
  #services.endlessh = {
  #  enable = true;
  #  openFirewall = true;  # Default=false
  #  port = 22;            # Default=2222
  #  extraOptions = [];    # Default=[]
  #};

  # --- fail2ban ---
  #services.fail2ban = {
  #  jails = {
  #  };
  #};

  # --- PAM ----------------------------------------------------------
  security.pam.enableSSHAgentAuth = true;  # Enable sudo logins if user's SSH agent provides a key present in ~/.ssh/authorized_keys. Allows machines to exclusively use SSH keys instead of passwords.
  security.pam.p11.enable = true;          # Enables P11 PAM (pam_p11) module. If set, users can login w/ SSH keys & PKCS#11 tokens. See: https://github.com/OpenSC/pam_p11
  #security.pam.services.<name>.sshAgentAuth = false; # If set, calling user's SSH agent is used to authenticate against the keys in their ~/.ssh/authorized_keys. Useful for sudo on password-less remote systems.

  # --- ussh ---
  #security.pam.services.<name>.usshAuth = false; # If set, users w/ SSH certificate containing an authorized principal in their SSH agent are able to login. Specific options under: security.pam.ussh
  #security.pam.ussh = {                         # Uber's SSH certificate auth PAM module
  #  enable = true;                              # Enable ussh
  #  authorizedPrincipals = null;                # Comma-sep list of permitted authorized principals. Auth if user presents cert w/ one of these. Requires cert contains a principal matching user's username. Mutually exclusive w/ authorizedPrincipalsFile.
  #  authorizedPrincipalsFile = null;            # File containing above ^^. Type=null|path. Comma-sep or newline-sep?
  #  caFile = null; #"/etc/ssh/trusted_user_ca"; # By default pam-ussh reads the trusted user CA keys from /etc/ssh/trusted_user_ca. This should be set the same as your TrustedUserCAKeys option for sshd.
  #  control = "sufficient";                     # PAM control. Use "required" for multi-factor auth. Use "sufficient" for using SSH cert instead of password. Options: required | requisite | sufficient | optional, See: pam.conf(5)
  #  group = null;                               # If set, authenticating user must be a member of this group.
  #};

  # --- SSSD ---------------------------------------------------------
  #services.sssd = let
  #  defaultConfig = ''
  #    [sssd]
  #    config_file_version = 2
  #    services = nss, pam
  #    domains = shadowutils
  #
  #    [nss]
  #
  #    [pam]
  #
  #    [domain/shadowutils]
  #    id_provider = proxy
  #    proxy_lib_name = files
  #    auth_provider = proxy
  #    proxy_pam_target = sssd-shadowutils
  #    proxy_fast_alias = True
  #  '';
  #  ldapConfigExtra = ''
  #    [domain/LDAP]
  #    ldap_default_authtok = $SSSD_LDAP_DEFAULT_AUTHTOK
  #  '';  # where env var is set to secret password
  #in {                      # System Security Services Daemon
  #  config = defaultConfig; # SSSD config text
  #  environmentFile = null; # Path to file containing environment variables for SSSD. "/etc/sssd/environmentFile";
  #  kcm = true;             # Use SSS as a Kerberos Cache Manager (KCM). Kerberos will be configured to cache credentials in SSS. Default=false
  #  sshAuthorizedKeysIntegration = true; # Make SSHD lookup authorized keys from SSS. The "ssh" SSS service must be enabled in the sssd configuration. Default=false
  #};
  #security.pam.services.<name>.sssdStrictAccess = false;  # Enforce SSSD access control.


  # --- MOTD ---------------------------------------------------------
  programs.rust-motd.enableMotdInSSHD = true;  # Let openssh print result when entering new ssh session. Incompatible w/ users.motd

  # --- tmate --------------------------------------------------------
  #services.tmate-ssh-server = {       # Service to share terminal sessions
  #  enable = true;                    # Default=false
  #  host = config.networking.fqdn;    # Default=config.networking.domain|config.networking.hostName
  #  keysDir = null;                   # Default=null  Dir containing SSH keys, defaults to auto-generation. Type: null|string
  #  openFirewall = true;              # Default=false
  #  package = pkgs.tmate-ssh-server;  # Default=pkgs.tmate-ssh-server
  #  port = 2222;                      # Default=2222
  #};
}
