{ config, lib, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  hardware.opengl.enable = true;
  #programs.wshowkeys.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Try to force Electron apps to use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = lib.mkIf config.programs.firefox.enable "1";
  };
  environment.systemPackages = [ pkgs.wl-clipboard ];
}
