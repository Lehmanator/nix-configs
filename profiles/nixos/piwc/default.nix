{ inputs, self
, config, lib, pkgs
, system
, host, network
, ...
}:
let
  prefix-ipv4 = "10.17.1";
  extern-ipv4 = "173.90.248.196";
in
{
  imports = [
    #./azure-active-directory.nix
    #./common
    #./hosts.nix
    #./networking.nix
    #./quickbooks.nix
    ./samba-client.nix
    #./wireguard.nix
  ];

  networking.hosts = {
    "${extern-ipv4}"     = [ "PIWC"                           "PIWC.wan"                  "PI.wan" ];
    "${prefix-ipv4}.80"  = [ "TEMPDC"                       "TEMPDC.lan"            "TEMPDC.local" ];
    "${prefix-ipv4}.81"  = [ "PIW-DC01"                   "PIW-DC01.lan"          "PIW-DC01.local"
                             "PI"                               "PI.lan"                "PI.local"
                             "dc01"                           "dc01.lan"              "dc01.local"
                             "ds01"                           "ds01.lan"              "ds01.local" ];
    "${prefix-ipv4}.1"   = [ "switch-creekside0" "switch-creekside0.lan" "switch-creekside0.local" ];
    "${prefix-ipv4}.2"   = [ "switch-creekside1" "switch-creekside1.lan" "switch-creekside1.local" ];
    "${prefix-ipv4}.4"   = [ "router-creekside"   "router-creekside.lan"  "router-creekside.local" ];
    "${prefix-ipv4}.101" = [ "router-islehouse"   "router-islehouse.lan"  "router-islehouse.local" ];
    "${prefix-ipv4}.136" = [ "router-bottling"     "router-bottling.lan"   "router-bottling.local" ];
    "${prefix-ipv4}.248" = [ "PIWINE-FACTS"           "PIWINE-FACTS.lan"      "PIWINE-FACTS.local" ];
    "${prefix-ipv4}.115" = [ "DESKTOP-SALES"         "DESKTOP-SALES.lan"     "DESKTOP-SALES.local" ];
    "${prefix-ipv4}.111" = [ "DESKTOP-R8NO4AD"     "DESKTOP-R8NO4AD.lan"   "DESKTOP-R8NO4AD.local"
                             "DESKTOP-COUNTER"     "DESKTOP-COUNTER.lan"   "DESKTOP-COUNTER.local" ];
  };
  networking.domain = "pi.wine";
  networking.search = [
    "piwine.com"
    "pi.wine"
    "pi.local"
    "dev.pi.wine"
    "beta.pi.wine"
    "prod.pi.wine"
    "test.pi.wine"
  ];

  services.onedrive.enable = true;

  # See: https://wiki.generaloutline.com/share/dfa77e56-d4d2-4b51-8ff8-84ea6608faa4
  #services.outline.azureAuthentication = {};

  #services.davmail.enable = true;
}
