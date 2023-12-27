{
  config, lib, pkgs,
  ...
}:
let
  # TODO: Use `services.xserver.wayland` to set xdotool/ydotool
  dotool = pkgs.ydotool;
in
{
  imports = [
  ];


}
