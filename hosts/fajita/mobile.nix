{ config, lib, pkgs, ... }:
{
  mobile = {
    enable = true;
    adbd.enable = true;
    beautification = {
      silentBoot = true;
      splash = true;
      useKernelLogo = true;
    };
    #boot = {
    #  boot-control.enable = true;
    #  stage-1.extraUtils = [
    #    {package=pkgs.name; extraComman="";}
    #  ];
    #  stage-1.gui.enable = true;
    #};
  };
}
