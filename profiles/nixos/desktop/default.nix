{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.srvos.nixosModules.desktop ./apps ./de ./gdm.nix];

  boot.kernelPackages =
    lib.mkIf (pkgs.system == "x86_64-linux") pkgs.linuxPackages_zen;

  programs.fuse.userAllowOther = true;

  # Out of Memory
  #systemd.oomd.enable = true;  # default: true
  services.earlyoom.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  environment.profileRelativeSessionVariables.QT_PLUGIN_PATH =
    lib.mkIf config.qt.enable ["/lib/qt-6/plugins"];
}
