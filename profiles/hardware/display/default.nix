{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    #./touchscreen.nix
    #../laptop.nix
    #../tablet.nix
    #../phone.nix
  ];

  environment.systemPackages = [
  ];

  hardware.opengl = rec {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    #extraPackages = [
    #  pkgs.intel-media-driver
    #  pkgs.intel-ocl
    #  pkgs.intel-vaapi-driver
    #];
    #extraPackages32 = lib.mkIf driSupport32Bit (extraPackages ++ [
    #]);
  };

  qt.enable = true;

  services = {
    autorandr.enable = true;
    xserver.enable = true;
  };

}
