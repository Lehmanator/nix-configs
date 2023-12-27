{
  config, lib, pkgs,
  ...
}:
let
  # TODO: TEST ME
  # TODO: Use `services.xserver.wayland` to set xdotool/ydotool
  dotool = pkgs.ydotool;
in
{
  imports = [
  ];

  services.fusuma.enable = false;
  services.fusuma.extraPackages = [ pkgs.xdotool pkgs.ydotool ];
  services.fusuma.settings = {
    threshold = {
      swipe = 0.1;
    };
    interval = {
      swipe = 0.7;
    };
    pinch = {
      in  = { command = "ydotool key Ctrl+Super+Up";   threshold = 0.75"; };
      out = { command = "ydotool key Ctrl+Super+Down"; threshold = 0.75"; };
    };
    swipe = {
      "3" = {
        left = { command = "ydotool key super+alt+Right"; threshold = 0.1; };
        right.command = "ydotool key super+alt+Left";
        up.command    = "ydotool key super+alt+Up";
        down.command  = "ydotool key super+alt+Down";
      };
    };
  };
}
