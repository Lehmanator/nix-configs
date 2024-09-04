{ inputs, cell
, config, lib, pkgs
, ...
}:
{
  # TODO: Home-Manager configure files in ~/.config/cosmic
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  services = {
    desktopManager.cosmic = {
      enable = true;
      xwayland.enable = lib.mkDefault true;
    };
    displayManager.cosmic-greeter.enable = lib.mkDefault true;
  };
  
  environment.cosmic.excludePackages = [
    pkgs.cosmic-edit  
  ];
  
  # Nvidia's experimental framebuffer device.
  #  Enable if using Nvidia GPU.
  # boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
