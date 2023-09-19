{ self, inputs
, config, lib, pkgs
, ...
}:
# TODO: https://reddit.com/r/NixOS/comments/ias64k/comment/g1s1fyh
#
# Usage:
#   adcli       - https://www.freedesktop.org/software/realmd/adcli/adcli.html
#   SilentHound - https://github.com/layer8secure/SilentHound
#
{
  imports = [
    #./ldap-admin.nix
    #./linux-admin.nix
    #./windows-admin.nix
  ];

  home.packages = [
    pkgs.adcli          # Tools for Active Directory client operations & helper library
    pkgs.adenum         # Tool to find misconfiguration through LDAP
    #pkgs.adtool        # Active Directory administration utility
    pkgs.apache-directory-studio # Eclipse-based LDAP browser & directory client
    #pkgs.certipy       # Tool to enumerate & abuse misconfigurations in Active Directory Certificate Services (temporarily disabled bc broken)
    pkgs.jxplorer       # Java LDAP browser (WARN: Last updated in 2018)
    pkgs.ldapdomaindump # Tool to dump all info about LDAP / AD domains
    pkgs.ldapmonitor    # Tool to monitor creation, deletion, & changes to LDAP objects
    pkgs.ldapvi         # Like vipw for LDAP
    pkgs.ldeep          # Tool to enumerate LDAP directories
    pkgs.msldapdump     # Tool to enumerate LDAP directories
    pkgs.silenthound    # Tool to enumerate an Active Directory Domain
    #pkgs.python311Packages.adal                 # Module to authenticate to Azure Active Directory to access AAD protected web resources  # Broken: 20230808
    pkgs.python311Packages.dsinternals          # Module to interact w/ Windows Active Directory
    #pkgs.python311Packages.ldapdomaindump       # Active Directory information dumper via LDAP
    pkgs.python311Packages.ms-active-directory  # Module for integrating w/ Microsoft Active Directory domains
    pkgs.python311Packages.msal                 # Lib to access Microsoft Cloud by supporting authentication of users w/ Microsoft Azure Active Directory accounts (AAD) & Microsoft Accounts (MSA) using OAuth2 & OpenID Connect
    pkgs.python311Packages.msldap               # Lib to access Microsoft Cloud by supporting authentication of users w/ Microsoft Azure Active Directory accounts (AAD) & Microsoft Accounts (MSA) using OAuth2 & OpenID Connect
    pkgs.powershell

    # --- Nix User Repository ---
    pkgs.nur.repos.exploitoverload.ADCSKiller
  ];

  home.shellAliases = {
    ad-info      = "silenthound --username 'slehman@PI.local' --groups --org-unit --kerberoast 10.17.1.81 PI.local";
    ad-nmap      = "nmap -A 10.17.1.81";
    ad-nmap-slow = "nmap -A 10.17.1.81 -T0 -D 10.17.1.128,10.17.1.115,10.17.1.111,10.17.1.93";
  };
}
