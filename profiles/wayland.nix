{ self, system, userPrimary, inputs, config, lib, pkgs, ... }:
let
in
{
  imports = [
    ./xserver.nix
  ];
  
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
  
  hardware.opengl.enable = true;

  #programs.wshowkeys.enable = true;

  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.windowManager.qtile.backend = "wayland";
}
