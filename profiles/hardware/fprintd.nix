{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  services.fprintd = {
    enable = false;
    #tod.enable = true;
    #tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  #security.pam.services.<NAME>.fprintAuth = true;
  #security.pam.services.login.fprintAuth = config.services.fprintd.enablee;

  #pam_ccreds

}
