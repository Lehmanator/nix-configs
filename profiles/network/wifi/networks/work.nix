{ inputs
, config
, lib
, pkgs
, ...
}:
let
  main = {
    psk = "@PSK_WORK@";
    hidden = false;
    authProtocols = [ "WPA-PSK" ];
    auth = null; # Mutually-exclusive w/ psk & pskRaw options
  };
in
{
  imports = [ ];
  networking.wireless.networks = {
    "PIWC" = main;
    "PIWC-5G" = main;
    "!Piwine!" = { psk = "!Winery64"; authProtocols = [ "WPA-PSK" ]; hidden = false; auth = null; };
  };
}
