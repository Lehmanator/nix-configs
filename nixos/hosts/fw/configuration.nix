# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs
, config
, lib
, pkgs
, user
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
  hardware = {
    enableAllFirmware = true;
    framework.enableKmod = true;
  };
  networking.hostName = "fw";

  # --- Users ---
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${user}" = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];

    # TODO: Collect from flake outputs? Filter out duplicates & prevent infinite recursion.
    # cell.nixosConfigurations.config.users.users.${user}.openssh.authorizedKeys.keys
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoHifjJL0fMBZDjNnXvSDhr0cwgkU80ybVeKRnly7Ku u0_a263@localhost"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn5m9GuM7DgUwKEienhfXC38a2UTWCCHsXwJSeOeXaNegYeHcPMp1NTwJ04CV6YwXUzVjehyOtDFVQ7XvnwsjOYAK1suYIw5tt2LeejTk4cYnnplHEmoxvQuc6tLK62w3/ar+Ba6OEJdf+9Mv0uJSEYliX9sF/PPce3YrdMKYesn75qyU0xvnfDTsEyXh6ldwMUfLiviY/yfYWAyOPX2LoBWskpLtsPNVQm5Fyjqzm/CjKlv2ILZm5BH6PjLb+wa1bgk0aSFcx82CNVgY7Bh9aWnN+yzbIIzn4VSHOVV/RWQk8OfIZ3F2HBJ+OPZq3fEa9PVIGNCBmzjUxlTcofcNAeVc0LAbqV5PUwhKayCS1Lh3ehUNf83+L0hle4FYtvWu84GoQRf/0OmhOiVeaK6xmvNL7zSoWurTWlMCs9FZxPGMRb5KdmOqhHjGNd82tyGYGNkykzAgs14BZvmd4h0w7J98k5UOsF0a6fZnA3AQQwfQdrB4fKsuxGoWt4pD47UQ3KjO71OwYsVREvkkeRKnYMbV3zJ2SPRU1NoL2ZgptRdRjyFu5HqXndUwoEcgWT1FC5NQqj+r0PYyRzS7qMyHG9T2KvYd3jDXZNDYUvTGJfKvf2TDJ2m2Ix001go/68EdbdpRkVRMPoi2gg/K/WbvOwhDAaRh8a+A/0JfMNoo3vQ== u0_a263@localhost"
    ];
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
    #firefox.enable = true;

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
