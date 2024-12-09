{ config, lib, pkgs, ... }:
{
  programs.helix.extraPackages = [pkgs.python3Packages.python-lsp-server];

  # TODO: python with packages
  home.packages = [
    pkgs.python3
    pkgs.python3Packages.xlsxwriter
    pkgs.python3Packages.xlrd
    pkgs.python3Packages.pyexcel-io
    pkgs.python3Packages.pyexcel-xls
    pkgs.python3Packages.pyexcel-ods
    pkgs.python3Packages.pyexcel
  ];
}
