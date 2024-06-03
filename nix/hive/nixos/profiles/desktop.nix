{ inputs, cell, config, lib, pkgs, ... }: {
  imports = [

    # Loads nixosModules: common, desktop.pipewire
    inputs.omnibus.flake.inputs.srvos.nixosModules.desktop

    cell.nixosProfiles.flatpak
    cell.nixosProfiles.gdm
    cell.nixosProfiles.libreoffice
    cell.nixosProfiles.oomd
  ];

  boot.kernelPackages = lib.mkIf pkgs.stdenv.isx86_64 pkgs.linuxPackages_zen;

  environment = {
    profileRelativeSessionVariables.QT_PLUGIN_PATH = lib.mkIf config.qt.enable
      [ "/lib/qt-6/plugins" ];

    systemPackages = [
      # TODO: Create nixosProfiles.fuse
      pkgs.fuse3 pkgs.fuse-common
    ];
  };

  programs.fuse.userAllowOther = true;

  # Enable CUPS to print documents
  services.printing.enable = lib.mkDefault true;
}
