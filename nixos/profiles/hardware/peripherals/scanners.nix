{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  # https://nixos.wiki/wiki/Scanners
  imports = [ (inputs.nixpkgs + "/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix") ]; # Brother Scanners
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan # Driverless Apple AirScan & Microsoft WSD
      pkgs.hplipWithPlugin # HP Scanners
      pkgs.epkowa # Epson Scanners
      pkgs.utsushi # Miscellaneous Scanners
    ];
    # Brother Scanners
    brscan4 = {
      enable = true;
      netDevices = {
        home = { model = "MFC-L2700DN"; ip = "192.168.178.23"; };
      };
    };
  };
  services.udev.packages = [ pkgs.utsushi ]; # Miscellaneous Scanners
  users.users.${user}.extraGroups = [ "scanner" "lp" ];

  # Network Scanning
  # TODO: Conditional based on if using Avahi for mDNS
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  # GIMP Support
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };
}
