{ inputs, cell, config, lib, pkgs, ... }: {
  imports = [ cell.nixosProfiles.xserver-base ];
  hardware.opengl.enable = true;
  #programs.wshowkeys.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.windowManager.qtile.backend = "wayland";

  # Try to force Electron apps to use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = lib.mkIf config.programs.firefox.enable "1";
  };
  environment.systemPackages = [ pkgs.wl-clipboard ];
}
