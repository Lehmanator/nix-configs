{ inputs, self
, config, lib, pkgs
, ...
}:
let
  ssid = "Lehman";
in
{
  imports = [
  ];

  networking.wireless.networks."${ssid}" = {
    psk = "@PSK_HOME@";
    hidden = false;
    authProtocols = [ "WPA-PSK" ];
    auth = null;   # Mutually-exclusive w/ psk & pskRaw options
  };

}
