{ config, lib, pkgs, ... }:
{
  # --- Profile to enable support for Nvidia GPUs ---
  # Enable nvidia-docker wrapper, supporting NVIDIA GPUs inside docker containers.
  virtualisation.docker.enableNvidia = true;
  virtualisation.podman.enableNvidia = true;

  # From: https://github.com/lilyinstarlight/nixos-cosmic
  # If while using an Nvidia GPU, cosmic-settings & cosmic-randr list show an additional display that can not be disabled, try Nvidia's experimental framebuffer device.
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
