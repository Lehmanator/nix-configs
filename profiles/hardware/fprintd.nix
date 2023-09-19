{ inputs, self
, config, lib, pkgs
, ...
}:
# Clear fprint storage
# - https://github.com/nixvital/fprint-clear
#
# $ sudo nix develop "github:nixvital/fprint-clear
# $ fprint-clear
#
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
