{ self, inputs
, config, lib, pkgs
, ...
}:
let
  variant = "fresh"; # fresh | still
  uno = false;       # Python library
  unwrapped = uno;
  libreoffice = if unwrapped then pkgs."libreoffice-${variant}" else pkgs."libreoffice-${variant}-unwrapped";
in
{

  environment.systemPackages = [
    libreoffice

    pkgs.hunspell
    pkgs.hunspellDicts.en_US-large
    pkgs.hunspellDicts.es_MX

    pkgs.csv2odf

    pkgs.unoconv
  ];

  environment.sessionVariables = lib.mkIf uno {
    PYTHONPATH = "libreoffice-${variant}-unwrapped/lib/libreoffice/program";
    URE_BOOTSTRAP = "vnd.sun.star.pathname:libreoffice-${variant}-unwrapped/lib/libreoffice/programs/fundamentalrc";
  };
}
