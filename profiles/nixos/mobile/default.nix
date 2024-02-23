{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [
    #./bootsplash-enable.nix
    #./bootsplash-disable.nix
    #./encrypted-root.nix
    #./gnome.nix
    ./buttons.nix
  ];

  # Configure options from nixosModule: NixOS/mobile-nixos
  mobile = {
    enable = true;
    adbd.enable = true;
    beautification = {
      silentBoot = lib.mkDefault true;
      splash = lib.mkDefault true;
      useKernelLogo = lib.mkDefault true;
    };
    #boot = {
    #  #boot-control.enable = lib.mkDefault false; # modules/hardware-qualcomm: true;
    #  stage-1.gui.enable = lib.mkDefault false;
    #  #stage-1.extraUtils = [{package=pkgs.unl0kr; extraCommand="";}];
    #};
  };

  hardware = {
    #pulseaudio.enable = true;
    sensor.iio.enable = true;
  };
  sound.enable = true;
  zramSwap.enable = true;
  #system.stateVersion = "23.11";
  #networking.firewall.enable = false;

  services = {
    openssh.enable = true;
    #pipewire.enable = lib.mkForce false;
  };

  environment = {
    # Disable GNOME apps that aren't mobile-friendly yet.
    gnome.excludePackages = (with pkgs.gnome; [
      baobab
      evince
      gnome-music
      gnome-system-monitor
      simple-scan
      totem
      yelp
    ]) ++ [ pkgs.gnome-tour ];

    # Reset IM_MODULE to fix on-screen keyboard
    variables = {
      GTK_IM_MODULE = lib.mkForce "";
      QT_IM_MODULE = lib.mkForce "";
      XMODIFIERS = lib.mkForce "";
    };

  };

  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    #passwordFile = config.sops.secrets.user-default-password.path;
    extraGroups = [ "dialout" "feedbackd" "networkmanager" "video" "wheel" "gdm" ];
  };
  #sops.secrets.user-default-password = {};
}
