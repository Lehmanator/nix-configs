{ inputs, config, lib, pkgs, ... }:
{
  imports = [ (inputs.self + /nixos/profiles/pipewire.nix) ];

  # Audio effects for Pipewire & apps
  environment.systemPackages = lib.mkIf config.services.pipewire.audio.enable [
    pkgs.easyeffects
    pkgs.gnomeExtensions.easyeffects-preset-selector # environment.systemPackages = [pkgs.easyeffects];
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-base
  ];

}
