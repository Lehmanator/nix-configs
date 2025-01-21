{ config, lib, pkgs, ... }:
{
  imports = [
    # ./common.nix
    # ./common-gui.nix
    # ./common-mobile.nix
    # ./arch-aarch64-linux.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  # TODO: Split packages into user & system-wide
  environment.systemPackages = [
    pkgs.grim               # Screenshot CLI
    pkgs.mepo               # Simple OSM map viewer
    pkgs.powersupply        # Display power status on mobile Linux
    pkgs.jellyfin-mpv-shim  # Allows casting of videos to MPV via the jellyfin mobile and web app
    pkgs.sharing            # 
    pkgs.livi               # 
    pkgs.hydrogen-web       # Matrix WebUI mobile-friendly
    pkgs.swipe-guess        # Completion plugin for touchscreen-keyboards on mobile devices
    pkgs.modem-manager-gui  # App to send/receive SMS, make USSD requests, control mobile data usage and more
    pkgs.jogger             # Track workouts
    pkgs.caerbannog         # Mobile-friendly Gtk frontend for password-store
    pkgs.gammu              # CLI to control mobile phones
    pkgs.selendroid         # Test automation for native or hybrid Android apps and the mobile web
    pkgs.firefox-mobile     # Firefox with mobile config UI
    pkgs.numberstation      # Authenticator. Generate 2FA token using installed secret. Add URLs from apps (Like Camera) w/ uri-handler: `otpauth://`
  ];
}
