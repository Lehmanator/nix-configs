# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ self
, inputs
, config
, lib
, pkgs
, user ? "sam"
, ...
}: {
  imports = [
    # Include SnowflakeOS config
    #./snowflake.nix

    # Include the results of the hardware scan.
    #./hardware-configuration.nix

    #./displays.nix

    # Activate profiles
    ../../profiles/adb.nix
    ../../profiles/boot
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    #../../profiles/editor
    ../../profiles/hardware/displaylink.nix
    #../../profiles/hardware/fprintd.nix
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/logitech.nix
    ../../profiles/hardware/tpm2.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles/nixos
    ../../profiles/piwc
    ../../profiles/polkit.nix
    ../../profiles/shell
    ../../profiles/sops.nix
    ../../profiles/sshd.nix
    ../../profiles/users
    ../../profiles/virt
    #../../profiles/virt/windows
    ../../profiles/workarounds.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "23.11"; # Did you read the comment?
  system.stateVersion = "23.05"; # Did you read the comment?

  # --- Cross-compilation ---
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    #"aarch64-darwin" "x86_64-darwin"
  ];
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  console.useXkbConfig = true;
  hardware.enableAllFirmware = true;
  hardware.opengl.driSupport32Bit = true;
  networking.hostName = "fw";

  # --- Users ---
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."sam" = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];
  };

  #users = {
  #  groups = {
  #    nm-openconnect = {};
  #    #netdev = {};
  #  };
  #  #extraGroups = {
  #  #  # Fix for D-Bus error on missing group: netdev
  #  #  # TODO: Figure out what causes this error (sshd? pkcs? pam? pam-pkcs11?)
  #  #  netdev = { name = "netdev"; };
  #  #};
  #  extraUsers = {
  #    # Fix for D-Bus error on missing user: nm-openconnect
  #    # TODO: Figure out what causes this error (sshd? pkcs? pam? pam-pkcs11? OpenConnect? NetworkManager?)
  #    nm-openconnect = {
  #      name = "nm-openconnect";
  #      description = "System user to control OpenConnect in NetworkManager";
  #      isSystemUser = true;
  #      group = "nm-openconnect";
  #      extraGroups = [
  #        #"netdev"
  #        "networkmanager"
  #      ];
  #    };
  #  };
  #};

  # TODO: Move most of these to home-manager profile (default user?)
  environment.systemPackages = with pkgs; [
    bat
    eza
    gcc
    lsd
    neofetch
    #ripgrep
    tealdeer
    gnumake
    lynis
  ];

  #programs.home-manager.enable = true;

  # --- Shell ---
  programs = {

    git = {
      enable = true;
      package = pkgs.gitFull;
    };

    less = {
      enable = true;
      lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
    };

    traceroute.enable = true;

    # --- Browsers ---
    chromium = {
      enable = true;
      defaultSearchProviderEnabled = true;
    };
    firefox.enable = true;

    # --- Keys ---
    gnupg = {
      dirmngr.enable = true;
      agent.enableExtraSocket = true;
      agent.enableBrowserSocket = true;
    };

  };

  qt.enable = true;

  nix.settings.trusted-public-keys = [
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
  ];

}
