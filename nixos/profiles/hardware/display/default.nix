{ config, lib, pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    #extraPackages32 = lib.mkIf enable32Bit (extraPackages ++ []);
    #extraPackages = [
    #  pkgs.intel-media-driver
    #  pkgs.intel-ocl
    #  pkgs.intel-vaapi-driver
    #];
  };

  qt.enable = true;

  services = {
    autorandr.enable = true;
    xserver.enable = true;
  };
}
