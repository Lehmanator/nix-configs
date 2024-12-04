{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.bustle #    #
    pkgs.d-spy #     #
    pkgs.sysprof #   #
  ];
}
