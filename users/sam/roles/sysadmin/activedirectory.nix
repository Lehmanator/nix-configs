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
  ];

  home.packages = [
    pkgs.adcli         # Tools for Active Directory client operations & helper library
    #pkgs.adtool        # Active Directory administration utility
    #pkgs.certipy       # Tool to enumerate & abuse misconfigurations in Active Directory Certificate Services (temporarily disabled bc broken)
    pkgs.silenthound   # Tool to enumerate an Active Directory Domain
    pkgs.python311Packages.adal                 # Module to authenticate to Azure Active Directory to access AAD protected web resources
    pkgs.python311Packages.dsinternals          # Module to interact w/ Windows Active Directory
    pkgs.python311Packages.ldapdomaindump       # Active Directory information dumper via LDAP
    pkgs.python311Packages.ms-active-directory  # Module for integrating w/ Microsoft Active Directory domains
    pkgs.python311Packages.msal                 # Lib to access Microsoft Cloud by supporting authentication of users w/ Microsoft Azure Active Directory accounts (AAD) & Microsoft Accounts (MSA) using OAuth2 & OpenID Connect
  ];
}
