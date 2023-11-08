{ pkgs, ... }:
{
  imports = [ ];

  services.mpd = {
    enable = true;
  };
  home.packages = [
    pkgs.chatterino2
    pkgs.streamlink
    #pkgs.mpd
    #pkgs.mpdas
    #pkgs.mpdris2
    #pkgs.mpd-mpris
    pkgs.ymuse
  ];

}
