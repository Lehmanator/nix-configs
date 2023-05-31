{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./apps
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Out of Memory
  #systemd.oomd.enable = true;  # default: true
  services.earlyoom.enable = true;

}
