{ pkgs, ... }: {
  imports = [ ];

  home.packages = [
    pkgs.libreoffice-fresh
    #pkgs.libreoffice-fresh-unwrapped
    #pkgs.libreoffice
  ];

}
