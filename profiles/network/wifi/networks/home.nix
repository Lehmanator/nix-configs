{ inputs
, config
, lib
, pkgs
, ...
}:
let
  ssid = "Lehman";
in
{
  networking.wireless.networks.${ssid} = {
    psk = "@PSK_HOME@";
    hidden = false;
    authProtocols = [ "WPA-PSK" ];
    auth = null; # Mutually-exclusive w/ psk & pskRaw options
  };

  sops.secrets.wifi-home-network = { };
}
