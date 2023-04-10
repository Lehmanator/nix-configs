{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
let
      # Framework Builtin Display
  frameworkDisplay = {
    enable = true;
    crtc = 1;
    mode = "2256x1504";
  };
in
{
  services.autorandr.enable = true;
  services.autorandr.defaultTarget = "docked";

  services.autorandr.profiles.mobile = {
    fingerprint.eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
    config.eDP-1 = frameworkDisplay // {
      primary = true;
    };
  };

  services.autorandr.profiles.docked = {

    fingerprint = {
      eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
      DP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
      DP-3 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-3";
    };

    config = {

      # Samsung UHD
      DP-1 = {
        enable = true;
        crtc = 0;
        mode = "3840x2160";
        position = "1024x0";
        primary = true;
      };

      # Dell VGA
      DP-3 = {
        enable = true;
        crtc = 2;
        mode = "1280x1024";
        position = "0x223";
        primary = false;
        rotate = "left";
      };

      # Framework Builtin Display
      eDP-1 = frameworkDisplay // {
        position = "4864x1276";
      };

    };
  };
}
