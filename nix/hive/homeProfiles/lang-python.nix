{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];
  home.packages = [
    pkgs.python3
    pkgs.python311Packages.xlsxwriter
    pkgs.python311Packages.xlrd
    pkgs.python311Packages.pyexcel-io
    pkgs.python311Packages.pyexcel-xls
    pkgs.python311Packages.pyexcel-ods
    pkgs.python311Packages.pyexcel
  ];
}
