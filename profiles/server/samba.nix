{
  self,
  inputs, outputs,
  profiles, suites,
  config, lib, pkgs,
  ...
}:
let
  # See: https://nixos.wiki/wiki/Samba
in
{
  imports = [
    #./ldap-admin.nix
  ];

  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # wsdd
  ];
  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user

      load printers = yes
      printing = cups
      printcap name = cups
    '';
    shares = {
      public = {
	path = "/mnt/Shares/Public";
	browseable = "yes";
	"read only" = "no";
	"guest ok" = "yes";
	"create mask" = "0644";
	"directory mask" = "0755";
	"force user" = "username";
	"force group" = "groupname";
      };
      private = {
	path = "/mnt/Shares/Private";
	browseable = "yes";
	"read only" = "no";
	"guest ok" = "no";
	"create mask" = "0644";
	"directory mask" = "0755";
	"force user" = "username";
	"force group" = "groupname";
      };
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = "yes";
        browseable = "yes";
        # to allow user 'guest account' to print.
        "guest ok" = "yes";
        writable = "no";
        printable = "yes";
        "create mode" = 0700;
      };
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];
}
