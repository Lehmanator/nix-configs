{ pkgs, ... }:
{
  imports = [ ];

  home.packages = [
    pkgs.chatterino
    pkgs.streamlink
  ];

}
