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
    ./de
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.fuse.userAllowOther = true;

  # Out of Memory
  #systemd.oomd.enable = true;  # default: true
  services.earlyoom.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;
}
