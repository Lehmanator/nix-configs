{ inputs, config, lib, pkgs, user, ... }:
{
  # Overlay our mobile forks of gnome-shell & mutter.
  nixpkgs.overlays = [
    (import ../../overlays/gnome-mobile)
    #(import inputs.self.overlays.gnome-mobile)
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
    boot = {
      boot-control.enable = lib.mkDefault true;
      stage-1.gui.enable = lib.mkDefault true;
      #stage-1.extraUtils = [{package=pkgs.unl0kr; extraCommand="";}];
    };
  };

  hardware = {
    #pulseaudio.enable = true;
    sensor.iio.enable = true;
  };
  sound.enable = true;
  zramSwap.enable = true;
  system.stateVersion = "23.11";
  #networking.firewall.enable = false;

  services = {
    logind = {
      powerKey = "ignore";
      powerKeyLongPress = "poweroff";
    };
    openssh.enable = true;
    #pipewire.enable = lib.mkForce false;
    xserver = {
      enable = true;
      videoDrivers = [ "modesetting" ];
      displayManager.gdm.enable = true;

      # Set workspaces so they work with mobile GNOME shell.
      desktopManager = {
        phosh.enable = false;
        gnome = {
          enable = true;
          extraGSettingsOverrides = ''
            [org.gnome.mutter]
            dynamic-workspaces=true
          '';
          extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
        };
      };
    };
  };

  # Install app to make phone calls
  programs.calls.enable = true;

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

    # Install mobile-friendly apps
    systemPackages = [
      pkgs.chatty # # IM & SMS
      pkgs.epiphany # # Web Browser
      pkgs.gnome-console # # Terminal
      pkgs.megapixels # # Camera
      pkgs.git # # For rebuilding w/ GitHub flakes
      #inputs.nix-software-center.packages.${pkgs.system}.nix-software-center
      #inputs.nixos-conf-editor.packages.${pkgs.system}.nixos-conf-editor
      #inputs.snow.packages.${pkgs.system}.snow
    ];
  };

  users.users.${user} = {
    isNormalUser = true;
    #passwordFile = config.sops.secrets.user-default-password.path;
    extraGroups = [ "dialout" "feedbackd" "networkmanager" "video" "wheel" ];
  };
  #sops.secrets.user-default-password = {};
}
