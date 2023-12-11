{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  mobile = {
    beautification = {
      silentBoot = lib.mkForce true;
      splash = lib.mkForce true;
      useKernelLogo = lib.mkForce true;
    };
    boot = {
      boot-control.enable = lib.mkDefault true;
      stage-1.gui.enable = lib.mkForce true;
      #stage-1.extraUtils = [{package=pkgs.unl0kr; extraCommand="";}];
    };
  };
}
