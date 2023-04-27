{ self, system, userPrimary, inputs, config, lib, pkgs,
  host, user, repo, network, machine,
  ...
}:
{
  imports = [
    ./xserver.nix
  ];

  environment.systemPackages = [ pkgs.wl-clipboard ];

  hardware.opengl.enable = true;

  #programs.wshowkeys.enable = true;

  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.windowManager.qtile.backend = "wayland";

  # Try to force Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
