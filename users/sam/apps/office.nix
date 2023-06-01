{ pkgs, ... }: {
  imports = [];

  home.packages = [
    pkgs.hunspell
    pkgs.hunspellDicts.en_US
    pkgs.libreoffice-fresh
    #pkgs.libreoffice-fresh-unwrapped
    #pkgs.libreoffice
    pkgs.onlyoffice-bin
  ];

}
