#
# This file represents safe opinionated defaults for a basic GNOME mobile system.
#
# NOTE: this file and any it imports **have** to be safe to import from
#       an end-user's config.
#
{ self, inputs,
  config, lib, pkgs,
  options,
  ...
}:
let
  inherit (lib) mkForce;
  system_type = config.mobile.system.type;
  defaultUserName = "sam";
in
{
  # --- gnome.nix ---
  # Sensible mobile defaults
  mobile.beautification = {
   silentBoot = lib.mkDefault true;
   splash = lib.mkDefault true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import ../../overlays/gnome-shell-mobile.nix)
  ];

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter.dynamic-workspaces]
      enabled=true
    '';
    extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  };
  services.xserver.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]);

  programs.calls.enable = true;

  environment.systemPackages = with pkgs; [
    chatty              # IM and SMS
    epiphany            # Web browser
    gnome-console       # Terminal
    megapixels          # Camera

    inputs.nix-software-center.packages."aarch64-linux".nix-software-center
    inputs.nixos-conf-editor.packages."aarch64-linux".nixos-conf-editor
    inputs.snow.packages."aarch64-linux".snow
    pkgs.git # For rebuiling with github flakes
  ];

  hardware.sensor.iio.enable = true;




  # --- configuration.nix ---
   users.users."${defaultUserName}" = {
      isNormalUser = true;
      password = "1234";
      extraGroups = [
        "dialout"
        "feedbackd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
    services.openssh = {
      enable = true;
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    services.pipewire.enable = lib.mkForce false;
    zramSwap.enable = true;
    networking.firewall.enable = false;
    system.stateVersion = "23.05";

  programs.nix-data = {
    systemconfig = "/etc/nixos/configuration.nix";
    flake = "/etc/nixos/flake.nix";
    flakearg = "fajita";
  };
  snowflakeos.gnome.enable = true;
  snowflakeos.osInfo.enable = true;
}
