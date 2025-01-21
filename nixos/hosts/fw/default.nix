{ inputs, config, pkgs, lib, user, ... }: 
{
  # https://github.com/nixvital/fprint-clear
  # https://github.com/ssddq/fw-ectool
  # https://github.com/mdvmeijer/fw-fanctrl-nix
  # https://github.com/DHowett/FrameworkHacksPkg
  # https://github.com/taotien/framework_toolbox
  # https://github.com/DHowett/framework-ec
  # https://github.com/morpheus636/awesome-framework

  imports = [
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    
    ./hardware-configuration.nix  # Configuration related to hardware
    ./displays.nix                # Handles hardware peripherals for external & internal displays
    ./managed.nix                 # Include app-managed config: nixos-conf-editor & nix-software-center
    
    (inputs.self + /nixos/profiles)
    (inputs.self + /nixos/profiles/bluetooth.nix)
    (inputs.self + /nixos/profiles/desktop)
    (inputs.self + /nixos/profiles/disko.nix)
    (inputs.self + /nixos/profiles/gnome)
    (inputs.self + /nixos/profiles/fprintd.nix)
    # (inputs.self + /nixos/profiles/displaylink.nix)
    (inputs.self + /nixos/profiles/hardware/peripherals/apple.nix)
    (inputs.self + /nixos/profiles/hardware/peripherals/logitech.nix)
    (inputs.self + /nixos/profiles/tlp.nix)
    (inputs.self + /nixos/profiles/lanzaboote.nix)
    (inputs.self + /nixos/profiles/plymouth.nix)
    (inputs.self + /nixos/profiles/systemd-boot.nix)
    (inputs.self + /nixos/profiles/systemd-initrd.nix)
    (inputs.self + /nixos/profiles/thunderbolt.nix)
    (inputs.self + /nixos/profiles/tpm2.nix)
    (inputs.self + /nixos/profiles/virt)
    
    # (inputs.self + /nixos/profiles/hercules-ci.nix)
    # (inputs.self + /nixos/profiles/slippi.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/printers.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/scanners.nix)
    # (inputs.self + /nixos/profiles/server/kubernetes/k3s-node-main.nix)
    # (inputs.self + /nixos/profiles/users/homed.nix)

    # --- Disabled ---
    # (inputs.self + /nixos/profiles/virt/windows)
    # (inputs.self + /common/profiles/editor)

    # --- Imported by profiles/nixos ---
    # (inputs.self + /nixos/profiles/nixos)
    # (inputs.self + /nixos/profiles/hardware)
    # (inputs.self + /nixos/profiles/locale)
    # (inputs.self + /nixos/profiles/network)
    # (inputs.self + /nixos/profiles/security)
    # (inputs.self + /nixos/profiles/sops.nix)
    # (inputs.self + /nixos/profiles/shell)
    # (inputs.self + /nixos/profiles/users)
  ];

  system.stateVersion = "23.05";
  networking.hostName = "fw";
  console.useXkbConfig = true;
  environment.etc.machine-id.text = "aa38a832d16e436d8aab8bb0550d4810";

  #isoImage.isoName =
  #  lib.mkImageMediaOverride
  #  "lehmanator-${config.system.build.installHostname}-${config.system.nixos.release}-${
  #    inputs.self.shortRev or "dirty"
  #  }-${pkgs.stdenv.hostPlatform.uname.processor}.iso";
  #isoImage.volumeID = "lehmanator-${config.system.nixos.release}-${
  #  inputs.self.shortRev or "dirty"
  #}-${pkgs.stdenv.hostPlatform.uname.processor}";
  #
  #system.build.installHostname = config.networking.hostName;
  #system.build.installClosure = config.system.build.toplevel;
  #system.build.installDiskoScript = config.system.build.diskoScript;
  #system.build.installer = pkgs.runCommandLocal config.isoImage.isoName {
  #  isoPath = "${config.system.build.isoImage}/iso/${config.isoImage.isoName}";
  #} ''ln -s "$isoPath" $out'';
  
  # --- Users ---
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${user}" = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];

    # Format: <options> <keyType> <base64-encoded-key> <comment>
    #    See: http://man.he.net/man5/authorized_keys
    # TODO: Collect from flake outputs? Filter out duplicates & prevent infinite recursion.
    # TODO: Only `ed-25519 keys`? 
    # TODO: Purpose-specific keys?
    #  - TODO: KDE Connect
    #  - TODO: Backup
    #  - TODO: Remote builders
    #  - TODO: 
    # cell.nixosConfigurations.config.users.users.${user}.openssh.authorizedKeys.keys
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn5m9GuM7DgUwKEienhfXC38a2UTWCCHsXwJSeOeXaNegYeHcPMp1NTwJ04CV6YwXUzVjehyOtDFVQ7XvnwsjOYAK1suYIw5tt2LeejTk4cYnnplHEmoxvQuc6tLK62w3/ar+Ba6OEJdf+9Mv0uJSEYliX9sF/PPce3YrdMKYesn75qyU0xvnfDTsEyXh6ldwMUfLiviY/yfYWAyOPX2LoBWskpLtsPNVQm5Fyjqzm/CjKlv2ILZm5BH6PjLb+wa1bgk0aSFcx82CNVgY7Bh9aWnN+yzbIIzn4VSHOVV/RWQk8OfIZ3F2HBJ+OPZq3fEa9PVIGNCBmzjUxlTcofcNAeVc0LAbqV5PUwhKayCS1Lh3ehUNf83+L0hle4FYtvWu84GoQRf/0OmhOiVeaK6xmvNL7zSoWurTWlMCs9FZxPGMRb5KdmOqhHjGNd82tyGYGNkykzAgs14BZvmd4h0w7J98k5UOsF0a6fZnA3AQQwfQdrB4fKsuxGoWt4pD47UQ3KjO71OwYsVREvkkeRKnYMbV3zJ2SPRU1NoL2ZgptRdRjyFu5HqXndUwoEcgWT1FC5NQqj+r0PYyRzS7qMyHG9T2KvYd3jDXZNDYUvTGJfKvf2TDJ2m2Ix001go/68EdbdpRkVRMPoi2gg/K/WbvOwhDAaRh8a+A/0JfMNoo3vQ== termux@cheetah"
      # TODO:  "ssh-ed25519  u0_a263@localhost"  # Flame   (Termux)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoHifjJL0fMBZDjNnXvSDhr0cwgkU80ybVeKRnly7Ku termux@cheetah"     # Cheetah (Termux)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtA7S/6BSsGRTTcKU/9+Aa/VsPCJzNkfjHbvFlaSVKN user@fajita-gnome"  # Fajita  (gnome)
      # +--[Hostname]--+--------[OS]--+--[Env]--+-------[OEM]--+--[Model Name]----+--[Codename]--+
      # | fw           |        NixOS | GNOME   |      Samsung | Galaxy S21 Ultra |              |
      # | wyse         |        NixOS | GNOME   |         Dell | Wyse 7040        |              |
      # | aio          |        NixOS | GNOME   |         Dell | Inspiron AIO     |              |
      # | raspi3       |        NixOS | Server  | Raspberry Pi | Raspberry Pi 3   |              |
      # | taba8        | PostmarketOS | GNOME   |      Samsung | Galaxy Tab A 8.0 |              |
      # | fajita-gnome | PostmarketOS | GNOME   |      OnePlus | 6T               | fajita       |
      # | fajita-phosh | PostmarketOS | Phosh   |      OnePlus | 6T               | fajita       |
      # | oriole       |      Android | Termux  |       Google | Pixel 6          | oriole       |
      # | raven        |      Android | Termux  |       Google | Pixel 6 Pro      | raven        |
      # | flame        |      Android | Termux  |       Google | Pixel 4          | flame        |
      # | taimen       |      Android | Termux  |       Google | Pixel 2 XL       | taimen       |
      # | sultra       |      Android | Termux  |      Samsung | Galaxy S21 Ultra |              |
      # +--------------+--------------+---------+---------------------------------+--------------+
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
