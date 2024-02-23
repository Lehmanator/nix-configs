{ config, lib, pkgs, ... }:
let
  # Framework Builtin Display
  frameworkDisplay = {
    enable = true;
    crtc = 1;
    mode = "2256x1504";
  };

  # Samsung UHD
  samsungUHD = {
    enable = true;
    crtc = 0;
    mode = "3840x2160";
    primary = true;
  };

  # Dell VGA
  dellVGA = {
    enable = true;
    crtc = 2;
    mode = "1280x1024";
    primary = false;
    rotate = "left";
  };

in
{
  services.autorandr = {
    enable = true;
    defaultTarget = "docked-2";

    profiles = {
      mobile = {
        fingerprint.eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
        config.eDP-1 = frameworkDisplay // { primary = true; };
      };
      docked-2 = {
        fingerprint = {
          eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
          DP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
          DP-3 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-3";
        };
        config = {
          eDP-1 = frameworkDisplay // { position = "4864x1276"; };
          DP-1 = samsungUHD // { position = "1024x0"; };
          DP-3 = dellVGA // { position = "0x223"; };
        };
      };
      docked-4k = {
        fingerprint = {
          eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
          DP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
        };
        config = {
          eDP-1 = frameworkDisplay // { position = "4864x1276"; };
          DP-1 = samsungUHD // { position = "0x0"; };
        };
      };
      docker-vga = {
        fingerprint = {
          eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
          DP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
        };
        config = {
          eDP-1 = frameworkDisplay // { position = "4864x1276"; };
          DP-1 = dellVGA // { position = "0x223"; };
        };
      };
    };
  };
}
