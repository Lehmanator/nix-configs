{ inputs
, config, lib, pkgs
, ...
}:
{
  isWayland = (
      (config.services.xserver.windowManager.qtile.backend == "wayland")
    || config.services.xserver.displayManager.gdm.wayland
    || config.sway.enable
    || config.hyprland.enable
    || config.miriway.enable
    || config.programs.xwayland.enable
    || config.programs.wshowkeys.enable
  );

}
