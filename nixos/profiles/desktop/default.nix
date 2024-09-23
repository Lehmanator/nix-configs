{ inputs, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
in
{
  imports = [
    inputs.srvos.nixosModules.desktop
    ./apps
    ./gnome
    ./flatpak.nix
    ./gdm.nix
    ./gtk.nix
    ./qt.nix
  ];

  # Use more responsive kernel on desktops (Non-ARM for now?)
  boot.kernelPackages = mkIf pkgs.stdenv.isx86_64 pkgs.linuxPackages_zen;

  environment.profileRelativeSessionVariables.QT_PLUGIN_PATH = mkIf config.qt.enable ["/lib/qt-6/plugins"];

  # Allow non-root users to perform FUSE mounts
  programs.fuse.userAllowOther = true;

  services = {
    #systemd.oomd.enable = true;  # default: true
    earlyoom.enable = true;  # Out of Memory, early process killer
    gvfs.enable     = true;  # Userspace virtual filesystem
    printing.enable = true;  # CUPS print server to enable printing
  };

}
