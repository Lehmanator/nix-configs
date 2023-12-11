{ inputs
, config
, lib
, pkgs
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

  home.packages = (with pkgs.python311Packages; [
    #adal #             # Module: Auth w/ AAD to access AAD-protected web resources # Broken: 20230808
    dsinternals #       # Module: Interact w/ Windows Active Directory
    ldapdomaindump #    # Bin: Active Directory information dumper via LDAP
    msal #              # Lib: access Microsoft Cloud by supporting authentication of users w/ Microsoft Azure Active Directory accounts (AAD) & Microsoft Accounts (MSA) using OAuth2 & OpenID Connect
    msldap #            # Lib: access Microsoft Cloud by supporting authentication of users w/ Microsoft Azure Active Directory accounts (AAD) & Microsoft Accounts (MSA) using OAuth2 & OpenID Connect
    ms-active-directory # Module: integrate w/ Microsoft Active Directory domains
  ]) ++ [
    pkgs.adcli #        # Tool: Active Directory client operations & helper library
    pkgs.adenum #       # Tool: Find misconfiguration through LDAP
    #pkgs.adtool #      # Tool: Active Directory administration utility
    #pkgs.certipy #     # Tool: Enumerate & abuse misconfigurations in Active Directory Certificate Services (temporarily disabled bc broken)
    pkgs.jxplorer #     # Tool: Java LDAP browser (WARN: Last updated in 2018)
    pkgs.ldapdomaindump # Tool: Dump all info about LDAP / AD domains
    pkgs.ldapmonitor #  # Tool: Monitor creation, deletion, & changes to LDAP objects
    pkgs.ldapvi #       # Tool: Like vipw for LDAP
    pkgs.ldeep #        # Tool: Enumerate LDAP directories
    pkgs.msldapdump #   # Tool: Enumerate LDAP directories
    pkgs.silenthound #  # Tool: Enumerate an Active Directory Domain
    pkgs.powershell #   # Microsoft shell
    pkgs.nur.repos.exploitoverload.ADCSKiller
  ] ++ lib.optionals pkgs.system == "x86_64-linux" [
    pkgs.apache-directory-studio # Eclipse-based LDAP browser & directory client
  ];

  home.shellAliases = {
    ad-info = "silenthound --username 'slehman@PI.local' --groups --org-unit --kerberoast 10.17.1.81 PI.local";
    ad-nmap = "nmap -A 10.17.1.81";
    ad-nmap-slow = "nmap -A 10.17.1.81 -T0 -D 10.17.1.128,10.17.1.115,10.17.1.111,10.17.1.93";
  };
}
