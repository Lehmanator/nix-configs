{ inputs, config, lib, pkgs, cell, ... }: {
  imports = [
    inputs.srvos.nixosModules.desktop
    cell.nixosProfiles.gdm
    cell.nixosProfiles.libreoffice
  ];

  boot.kernelPackages =
    lib.mkIf (pkgs.system == "x86_64-linux") pkgs.linuxPackages_zen;

  programs.fuse.userAllowOther = true;
  environment.systemPackages = [ pkgs.fuse3 pkgs.fuse-common pkgs.thunderbird ];

  # Out of Memory
  #systemd.oomd.enable = true;  # default: true
  services.earlyoom.enable = lib.mkDefault true;

  # Enable CUPS to print documents
  services.printing.enable = lib.mkDefault true;

  environment.profileRelativeSessionVariables.QT_PLUGIN_PATH =
    lib.mkIf config.qt.enable [ "/lib/qt-6/plugins" ];
}
