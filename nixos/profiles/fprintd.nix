{ config, lib, pkgs, ... }:
# Clear fprint storage
# - https://github.com/nixvital/fprint-clear
#
# $ sudo nix develop "github:nixvital/fprint-clear
# $ fprint-clear
#
# Oops, only provides devShell. TODO: Upstream packages & build devShell for other arches.
#environment.systemPackages = lib.mkIf pkgs.system=="x86_64-linux" [inputs.fprint-clear.packages.${pkgs.system}.default];
#
{
  services.fprintd = {
    enable = true;
    #tod.enable = true;
    #tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  #security.pam.services.<NAME>.fprintAuth = true;
  #security.pam.services.login.fprintAuth = config.services.fprintd.enablee;

  #pam_ccreds
}
