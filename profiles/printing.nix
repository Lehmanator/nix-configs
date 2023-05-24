{ self, inputs
, config, lib, pkgs
, username ? "sam"
, ...
}:
{
  # https://nixos.wiki/wiki/Scanners
  imports = [
    # Brother Scanners
    (inputs.nixpkgs + "/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix")
  ];

  # --- Printing -----------------------------------------------------
  # --- Scanning -----------------------------------------------------
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan    # Driverless Apple AirScan & Microsoft WSD
      pkgs.hplipWithPlugin # HP Scanners
      pkgs.epkowa          # Epson Scanners
      pkgs.utsushi         # Miscellaneous Scanners
    ];
    # Brother Scanners
    brscan4 = {
      enable = true;
      netDevices = {
        home = { model = "MFC-L2700DN"; ip = "192.168.178.23"; };
      };
    };
  };
  services.udev.packages = [
    pkgs.utsushi           # Miscellaneous Scanners
  ];
  users.users."${username}".extraGroups = [ "scanner" "lp" ];

  # Network Scanning
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # GIMP Support
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

}
