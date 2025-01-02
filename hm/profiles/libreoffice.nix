{ lib, pkgs, ... }: 
let
  variant = "fresh";  # fresh | still
  uno = false;        # Python library
in
{
  home.sessionVariables = lib.mkIf uno {
    PYTHONPATH = "libreoffice-${variant}-unwrapped/lib/libreoffice/program";
    URE_BOOTSTRAP = "vnd.sun.star.pathname:libreoffice-${variant}-unwrapped/lib/libreoffice/programs/fundamentalrc";
  };

  home.packages = [
    pkgs.libreoffice-fresh # libreoffice-fresh-unwrapped, libreoffice

    pkgs.hunspell
    pkgs.hunspellDicts.en_US-large
    pkgs.hunspellDicts.es_MX
  ];

}
