{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./browser-chromium
    ./browser-firefox
    #./browser-tor

    ./chat-pidgin
    #./chat-beeper
    ./chat-signal

    ./libreoffice
    #./onlyoffice

    #./passwords.nix
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
