{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = [
    # inputs.srvos.nixosModules.desktop
    (inputs.self + /nixos/profiles/gnome)

    (inputs.self + /nixos/profiles/flatpak.nix)
    (inputs.self + /nixos/profiles/gdm.nix)
    (inputs.self + /nixos/profiles/gtk.nix)
    (inputs.self + /nixos/profiles/qt.nix)

    # --- Apps ---------------------------------------------
    (inputs.self + /nixos/profiles/chromium.nix)
    (inputs.self + /nixos/profiles/firefox)
    # (inputs.self + /nixos/profiles/torbrowser.nix)
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # extraPackages = [pkgs.intel-media-driver pkgs.intel-ocl pkgs.intel-vaapi-driver];
  };
  qt.enable = lib.mkDefault true;

  # Use more responsive kernel on desktops (Non-ARM for now?)
  boot.kernelPackages = mkIf pkgs.stdenv.isx86_64 pkgs.linuxPackages_zen;

  environment.profileRelativeSessionVariables.QT_PLUGIN_PATH = mkIf config.qt.enable ["/lib/qt-6/plugins"];

  # Allow non-root users to perform FUSE mounts
  programs.fuse.userAllowOther = true;

  services = {
    autorandr.enable = true;
    xserver.enable = true;

    #systemd.oomd.enable = true;  # default: true
    earlyoom.enable = true; # Out of Memory, early process killer
    gvfs.enable = true; # Userspace virtual filesystem
    printing.enable = true; # CUPS print server to enable printing
  };

  # Improve desktop responsiveness when updating system
  nix.daemonCPUSchedPolicy = "idle";

  fonts = {
    # Enable a basic set of fonts providing several styles and families and reasonable coverage of Unicode.
    enableDefaultPackages = true;

    # Whether to create a directory with links to all fonts in:
    #   /run/current-system/sw/share/X11/fonts
    fontDir.enable = true;
  };

  xdg = {
    portal.enable = true;
    terminal-exec = {
      enable = true;
      # package = pkgs.xdg-terminal-exec;
      # settings = {};
    };
  };
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  environment.systemPackages = [
    pkgs.bitwarden
    pkgs.fuse3
    pkgs.thunderbird
  ];
}
