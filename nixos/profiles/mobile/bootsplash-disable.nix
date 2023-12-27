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
      silentBoot = lib.mkForce false;
      splash = lib.mkForce false;
      #useKernelLogo = lib.mkForce true;
    };
    boot = {
      #boot-control.enable = lib.mkDefault false;
      stage-1.gui.enable = lib.mkForce false;
      #stage-1.extraUtils = [{package=pkgs.unl0kr; extraCommand="";}];
    };
  };
}
