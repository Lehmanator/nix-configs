{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}: let
  inherit (lib) mkDefault mkForce mkIf fold recursiveUpdate;
  internal-tlds = ["local" "lan" "wan"]; # [ "work" "home" ];
  keyFormats = ["rsa" "ed25519"]; # [ "3des" ]; # etc...

  # Creates a list of FQDNs for a host given a list of domain names.
  # TODO: Mechanism for storing network details as secrets
  # TODO: Mechanism for collecting publicKeys & network details from a colemena swarm
  # TODO: Add local  IP addresses (per network w/ static DNS)
  # TODO: Add public IP addresses (per network w/ static DNS?)
  mkListFQQN = builtins.map (domainName: "${config.networking.hostName}.${domainName}");

  # Creates a list of FQDNs (including internal network TLDs)
  mkListHosts = domains: ipAddrs: (mkListFQQN (domains ++ internal-tlds)) ++ ipAddrs ++ [config.networking.hostName "localhost"];
  mkHostKeys = with config.sops.secrets; [
    {
      path = ssh-host-rsa-privkey.path;
      type = "rsa";
      bits = 4096;
      openSSHFormat = true;
      rounds = 100;
    }
    {
      path = ssh-host-ed25519-privkey.path;
      type = "ed25519";
      openSSHFormat = true;
    }
  ];
  mkKnownHostSelf = with config.sops.secrets;
    keyType: {
      publicKeyFile = ssh-host- "${keyType}" - pubkey.path;
      hostNames = mkListHosts domainNames [
        network-home-internal-ipv4
        network-home-external-ipv4
        network-home-ipv6
        network-home-internal-ipv4
        network-work-external-ipv4
        network-work-ipv6
      ];
    };
  #mkKnownHostsSelf = lib.lists.fold (keyType: kh: { "${config.networking.hostName}-${keyType}" = mkKnownHostSelf keyType; });
  mkKnownHostsSelf = fold (a: b: recursiveUpdate a (mkKnownHostsSelf b)) {} keyFormats;
  #{ "${config.networking.hostName}-rsa" = mkKnownHostSelf "rsa";
  #  "${config.networking.hostName}-ed25519" = mkKnownHostSelf "ed25519"; };
  mkConfigSSH = recursiveUpdate {
    hostKeys = mkHostKeys [];
    knownHosts = mkKnownHostsSelf;
  };
in {
  # imports = [./sshguard.nix ./fail2ban.nix ./tmate-ssh-server.nix];

  # --- Secrets ------------------------------------------------------
  #sops.secrets.ssh-host-rsa-privkey     = { owner = "root"; group = "root"; mode = "0600"; };
  #sops.secrets.ssh-host-rsa-pubkey      = { owner = "root"; group = "root"; mode = "0644"; };
  #sops.secrets.ssh-host-ed25519-privkey = { owner = "root"; group = "root"; mode = "0600"; };
  #sops.secrets.ssh-host-ed25519-pubkey  = { owner = "root"; group = "root"; mode = "0644"; };

  # --- SSHD ---------------------------------------------------------
  users.users.${user}.extraGroups = ["sshd"];
  services.openssh = {
    enable = true;

    # If set, SSHD is socket-activated,
    #  w/ systemd starting an instance for each incoming connection instead of running permanently as a daemon.
    # TODO: Enable to save CPU cycles
    startWhenNeeded = false;

    hostKeys = [
      {
        type = "rsa";
        path = "/etc/ssh/ssh_host_rsa_key";
        bits = 4096;
        openSSHFormat = true;
        rounds = 100;
      }
      {
        type = "ed25519";
        path = "/etc/ssh/ssh_host_ed25519_key";
      }
    ];

    # --- Remote Hosts ---
    # User Key: sam@wyse  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9rUBBvT6h8/IZVsaXbh5uOcuhnd66t+wI505S5RMUI sam@wyse";
    # User Key: sam@flame = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCXZ0IrztYHWnKNnvhHdBd/hnVea21ZrTRLSCNurEx9jTpIa2Zll2mC+GzO4HJvp/e+s+A2rDlyUbrZCdChC96UhlDK9auhHUW+Ot2SWRiGrn3IUHXU/Gpo9737BIYq3t4te2nVMJwcJ9AutOgabJvaUGz1rjNgpwBwBAMT8Yf1Ub9NGxJDSS6TjER2Po7NymxvyDA4PiTRkNNN66ALg/Soi6YsdjczgXc/07NGA7uKuZ/xX+mSUfkI+su/R7o5az7EmAMWgfrZq3UGkxQLPNCpEANhSLMyiOyS69ni07u81VCroMvcJMqqjJxb8KLSqBimv57ev8deQzD8WmqFphm1Gfb/RUU4tKdRMXpD4YoeqAJASlDp2lehvtlc7z4iGDt/sEVE5ix+92q5paca80ZSJvP6R4lcYAOkh9hzSNOwMrbL5HhBDkdNvPj3WuwYQ11P38ambXlZ0czg7aY4Q/gxjWD0kPWhyLZhtIi3l44wxzNhjXPVrO+hMMp/g+aT9Yn57I4/TQVeB39wN/oxVMsxX+fu3Ozhe4VYJpfS2lCRZIvD05PvVJISdGEJAHWxVfAIfROBsSZuOUFj3N2hh2Z7T2Vi8fhT1f/TIWAmvNfMxJLqxE5IgKl7N5DfUHCuGU5Eyn69e4wCQJyFbv9FXG5YUECy/Qn7BZPQTbEP8aZsiw== sam@flame";
    knownHosts = with config.networking; {
      # Dynamic host to match the current config.
      #"${hostName}" = mkKnownHostsSelf;

      cheetah = {
        # publicKeyFile = "/etc/ssh/hosts/cheetah.pub";
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoHifjJL0fMBZDjNnXvSDhr0cwgkU80ybVeKRnly7Ku u0_a263@localhost";
        hostNames = [
          "cheetah"
          "cheetah.tail3dfa6.ts.net"
          "100.100.1.1"
          "cheetah.lan"
          "cheetah.local"
          "192.168.1.101"
          "cheetah.wan"
          "cheetah.local"
          "cheetah.home" #"cheetah.${domain}"
          "cheetah.lehman.run"
          "cheetah.samlehman.dev"
          "cheetah.samlehman.dev"
        ];
      };
      cheetah-rsa = {
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn5m9GuM7DgUwKEienhfXC38a2UTWCCHsXwJSeOeXaNegYeHcPMp1NTwJ04CV6YwXUzVjehyOtDFVQ7XvnwsjOYAK1suYIw5tt2LeejTk4cYnnplHEmoxvQuc6tLK62w3/ar+Ba6OEJdf+9Mv0uJSEYliX9sF/PPce3YrdMKYesn75qyU0xvnfDTsEyXh6ldwMUfLiviY/yfYWAyOPX2LoBWskpLtsPNVQm5Fyjqzm/CjKlv2ILZm5BH6PjLb+wa1bgk0aSFcx82CNVgY7Bh9aWnN+yzbIIzn4VSHOVV/RWQk8OfIZ3F2HBJ+OPZq3fEa9PVIGNCBmzjUxlTcofcNAeVc0LAbqV5PUwhKayCS1Lh3ehUNf83+L0hle4FYtvWu84GoQRf/0OmhOiVeaK6xmvNL7zSoWurTWlMCs9FZxPGMRb5KdmOqhHjGNd82tyGYGNkykzAgs14BZvmd4h0w7J98k5UOsF0a6fZnA3AQQwfQdrB4fKsuxGoWt4pD47UQ3KjO71OwYsVREvkkeRKnYMbV3zJ2SPRU1NoL2ZgptRdRjyFu5HqXndUwoEcgWT1FC5NQqj+r0PYyRzS7qMyHG9T2KvYd3jDXZNDYUvTGJfKvf2TDJ2m2Ix001go/68EdbdpRkVRMPoi2gg/K/WbvOwhDAaRh8a+A/0JfMNoo3vQ== u0_a263@localhost";
      };

      #wyse = { publicKey = ""; #publicKeyFile = "/etc/ssh/hosts/wyse.pub";
      #         hostNames = [ "wyse" "192.168.1.2" "wyse.local" "wyse.lan" "wyse.wan" "wyse.home"
      #          "wyse.piwine.com" "wyse.lehman.run"                                                   ];
      #};
      #flame = { publicKey = ""; #publicKeyFile = "/etc/ssh/hosts/flame.pub";
      #         hostNames = [ "flame" "192.168.1.100" "flame.local" "flame.lan" "flame.wan" "flame.home"
      #          "flame.piwine.com" "flame.lehman.run"                                                   ];
      #};
    };
    # --- Networking ---
    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = 2223;
      }
      #{ addr = "192.168.3.1"; port = 22;   }
    ];
    openFirewall = mkDefault true;
    ports = [2224 2223];

    settings = {
      # TODO: Human users group: "@users"
      # TODO: Nix remote builders group: "@builders"?
      AllowGroups = ["sshd"];
      AllowUsers = [user];

      GatewayPorts = "no"; # Whether remote hosts allowed to connect to ports forwarded for client. sshd_config(5)
      KbdInteractiveAuthentication = mkDefault true; # Whether keyboard-interactive authentication is allowed.
      PasswordAuthentication = false; # (Dis)allow auth using passwords
      PermitRootLogin = "no"; # yes | without-password | prohibit-password | forced-commands-only | no
      UseDns = mkDefault true; # Lookup remote host name & check that resolved host name for remote IP maps to same IP.
      X11Forwarding = mkDefault true; # (Dis)allow X11 connections to be forwarded.
      #LogLevel = "INFO";                   # QUIET | FATAL | ERROR | INFO | VERBOSE | DEBUG | DEBUG1 | DEBUG2 | DEBUG3
      # --- Crypto Algorithms ---
      #Ciphers = [ "chacha20-poly1305@openssh.com" "aes256-gcm@openssh.com" "aes128-gcm@openssh.com" "aes256-ctr"             "aes192-ctr"             "aes128-ctr" ];
      #KexAlgorithms = [ "sntrup761x25519-sha512@openssh.com" "curve25519-sha256" "curve25519-sha256@libssh.org" "diffie-hellman-group-exchange-sha256" ];
      #Macs = [ "hmac-sha2-512-etm@openssh.com" "hmac-sha2-256-etm@openssh.com" "umac-128-etm@openssh.com" ];
    };
    # --- SFTP ---
    allowSFTP = mkDefault true;
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
  #services.openssh = {
  #  knownHosts = with config.networking; {
  #    "${hostName}" = mkKnownHostsSelf;
  #  };
  #  hostKeys = mkHostKeys;
  #  hostKeys = with config.sops.secrets; [
  #   {path=ssh-host-privkey-rsa.path; type="rsa"; openSSHFormat=true; bits=4096; rounds=100;}
  #   {path=ssh-host-privkey-ed25519.path; type="ed25519"; openSSHFormat=true;}
  #  ];
  #};
  networking.dhcpcd.persistent = true; # Set true if machine accepts SSH connections thru DHCP interfaces & clients should be notified when it shuts down.

  # --- SSH Security -------------------------------------------------
  services.sshguard = {
    # Service to block IP addresses attempting SSH brute force attacks.
    enable = true; # Enable sshguard service
    #attack_threshold = 30;     # Block attacker after cumulative attack score exceeds threshold. Most attacks' scores = 10
    blacklist_file = "/var/lib/sshguard/blacklist.db";
    blacklist_threshold = 120; # Blacklist attacker after score exceeds threshold.
    blocktime = 120; # Seconds to block attacker after exceeding threshold. Each subsequent block inc by 1.5x
    detection_time = 1000; # Remember potential attackers for up to this many seconds before resetting score.
    services = ["sshd"]; # systemd services sshguard should receive logs from.
    #  cockpit exim dovecot cucipop uwimap vsftpd postfix proftpd pure-ftpd
    whitelist = ["100.100.1.1" "100.65.77.40"];
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
  #security.pam.enableSSHAgentAuth = true;  # Enable sudo logins if user's SSH agent provides a key present in ~/.ssh/authorized_keys. Allows machines to exclusively use SSH keys instead of passwords.
  #security.pam.p11.enable = true;          # Enables P11 PAM (pam_p11) module. If set, users can login w/ SSH keys & PKCS#11 tokens. See: https://github.com/OpenSC/pam_p11
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
