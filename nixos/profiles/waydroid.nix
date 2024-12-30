{ config, lib, pkgs, ... }:
{
  # --- Waydroid -------------------------------------------
  virtualisation.waydroid.enable = true;
  virtualisation.lxd.enable = true;

  environment.systemPackages = [
    pkgs.genymotion                   # Fast and easy Android emulation
    pkgs.wl-clipboard                 # Needed to share wayland clipboard with waydroid
    # pkgs.nur.repos.ataraxiasjel.waydroid-script    # Script to add extras to waydroid
  ];
}
