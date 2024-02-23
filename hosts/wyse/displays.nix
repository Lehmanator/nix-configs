{ pkgs, ... }:
{
# - TODO: hosts.<hostname>.displays: file should only contain default display layout(s)
#
# - TODO: NixOS profiles: hardware.displays.{displaylink,hidpi,wireless,pinedock,docked.*,external.*,layouts.*}
#   - TODO: hidpi: imports=[inputs.nixos-hardware.nixosModules.common-hidpi];
#   - TODO: displaylink: Add boot.kernelModules & boot.initrd.kernelModules
#   - TODO: internal.<name>: fingerprint, resolution, randr config
#     - framework
#     - fajita
#     - samsung-t350
#   - TODO: external.<name>: fingerprint, resolution, randr config
#     - dell-square & pinedock-dell-square
#     - dell-rect   & pinedock-dell-rect
#     - asus        & pinedock-asus
#   - TODO: docked.<name>: Handle differences b/w using Pine64 dock & raw displays
#
  environment.systemPackages = [];
  # TODO: Package to query randr info (X11 / Wayland)
  # TODO: DisplayLink service?
  services.autorandr = {
    enable = true;
    defaultTarget = "all";
    profiles = let
      dell-square-vga = {
        enable = true;
        crtc = 2;
        mode = "1280x1024";
        primary = false;
        rotate = "left";
      };
      dell-rect-vga = {
        enable = true;
        primary = false;
      };
      dell-rect-dvi = {
        enable = true;
        primary = false;
      };
      asus-dvi = {
        enable = true;
        mode = "1920x1080";
        primary = true;
      };
    in {
      # --- Single Displays ---
      #dell-square = {};
      #dell-rect = {};
      #asus-1080p = {};

      # --- Two Displays ---
      # Dell-Square + Dell-Rect
      #lower = {
      #  fingerprint = {
      #  };
      #  config = {
      #  };
      #};

      # Dell-Rect + ASUS
      #rect = {
      #  fingerprint = {
      #  };
      #  config = {
      #  };
      #};

      # Dell-Square + ASUS
      #left = {
      #  fingerprint = {
      #  };
      #  config = {
      #  };
      #};

      # --- Three Displays ---
      all = {
        fingerprint = {
          eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
           DP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
          #DP-2 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-2";
           DP-3 = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-3";
        };
        config = {
          eDP-1 = asus-dvi        // { position =  "200x1024"; };
           DP-1 = dell-rect-vga   // { position = "1280x0";    };
          #DP-2 = dell-rect-vga   // { position = "1280x0";    };
           DP-3 = dell-square-vga // { position =    "0x223";  };
        };
      };
      docked-1 = {
        fingerprint.eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
        fingerprint.DP-1  = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
        fingerprint.DP-3  = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-3";
        config.DP-3       = dell-square-vga // { position = "0x223"; };
      };
      docked-vga = {
        fingerprint.eDP-1 = "--CONNECTED-BUT-EDID-UNAVAILABLE--eDP-1";
        fingerprint.DP-1  = "--CONNECTED-BUT-EDID-UNAVAILABLE--DP-1";
        config.DP-1       = dell-square-vga // { position = "0x223"; };
      };
    };
  };
}
