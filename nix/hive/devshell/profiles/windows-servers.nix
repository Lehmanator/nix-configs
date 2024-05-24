{ inputs, pkgs, ... }: {
  imports = [ ];
  env = [ ];
  commands = [ ];
  packages = [
    # --- Azure ---
    pkgs.waagent # The Microsoft Azure Linux Agent (waagent) manages Linux provisioning and VM interaction with the Azure Fabric Controller

    # --- Libraries ---
    # TODO: Wrap python with packages & libs
    #pkgs.pythonWithPackages (p: with p; [
    #  p.pythonPackages.pywinrm
    #])

    pkgs.python311Packages.pywinrm # Python module to interact with Windows Active Directory

    # --- Active Directory ---
    pkgs.adreaper # Enumeration tool for Windows Active Directories
    pkgs.enum4linux # A tool for enumerating information from Windows and Samba systems
    pkgs.ldapnomnom # Tool to anonymously bruteforce usernames from Domain controllers
    pkgs.ldapdomaindump # Active Directory information dumper via LDAP
    pkgs.python311Packages.ldapdomaindump # Active Directory information dumper via LDAP
    pkgs.nxdomain # A domain (ad) block list creator

    # --- Server Components ---
    pkgs.davmail # A Java application which presents a Microsoft Exchange server as local CALDAV, IMAP and SMTP servers
    pkgs.pykms # Windows KMS (Key Management Service) server written in Python
    pkgs.sqlcmd # A command line tool for working with Microsoft SQL Server, Azure SQL Database, and Azure Synapse

    # --- Intrusion & Pen-testing ---
    pkgs.dsniff # collection of tools for network auditing and penetration testing
    pkgs.findomain # The fastest and cross-platform subdomain enumerator
    pkgs.kerbrute # Kerberos bruteforce utility
    pkgs.spoofer-gui # Assess and report on deployment of source address validation
    pkgs.python311Packages.masky # Library to remotely dump domain credentials
    pkgs.terrascan # Detect compliance and security violations across Infrastructure

    # --- Servers ---
    pkgs.darkstat # Network statistics web interface
    pkgs.dico # Flexible dictionary server and client implementing RFC 2229
    pkgs.powerdns-admin # A PowerDNS web interface with advanced features
    pkgs.radicale2 # CalDAV CardDAV server
  ];
}
