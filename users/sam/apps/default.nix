{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./browsers.nix
    ./browser-chromium
    ./browser-firefox
    ./browser-tor

    ./chat-matrix
    ./chat-pidgin
    #./chat-beeper
    #./chat-discord
    #./chat-signal

    ./libreoffice
    #./onlyoffice

    #./passwords.nix
    ./bitwarden
    #./keepass
    #./nextcloud-passwords
    #./pass
  ];

  home.packages = [
    pkgs.hunspell
    pkgs.hunspellDicts.en_US
    pkgs.onlyoffice-bin
  ];

}
