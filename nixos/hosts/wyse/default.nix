{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  imports = with inputs; [
    #./configuration.nix # System configuration
    ./disko.nix # Disk configuration
    #./hardware-configuration.nix # Configuration related to hardware
    #./profiles.nix # Load profiles
    #./displays.nix # Handles hardware peripherals for external & internal displays
    #./managed.nix # Include configuration managed by apps: nixos-conf-editor & nix-software-center

    (modulesPath + "/installer/scan/not-detected.nix")
    disko.nixosModules.disko
    srvos.nixosModules.desktop
    #srvos.nixosModules.mixins-nix-experimental
    #srvos.nixosModules.mixins-systemd-boot
    #srvos.nixosModules.mixins-trusted-nix-caches
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-hardware.nixosModules.common-cpu-intel

    ../../profiles

    ../../profiles/boot
    #../../profiles/boot/unl0kr.nix
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    ../../profiles/hardware/display
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/peripherals/logitech.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/security/apparmor.nix
    #../../profiles/server/kubernetes/k3s-node-main.nix
    ../../profiles/users/homed.nix
    ../../profiles/virt
    #../../profiles/virt/emulators/slippi.nix

    #../../profiles/hardware/display/displaylink.nix
    #../../profiles/hardware/tpm1.2.nix
    #../../profiles/virt/windows
    #../../../common/profiles/editor
  ];

  boot = {
    binfmt.emulatedSystems = [
      "aarch64-linux" # "aarch64-darwin" "x86_64-darwin"
    ];
    extraModulePackages = [];
    kernelModules = ["kvm-intel"];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "thunderbolt"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = ["nvme"];
    };
    #loader.efi.efiSysMountPoint = "/boot/efi";
    loader.efi.efiSysMountPoint = lib.mkForce "/boot";
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  networking = {
    hostName = "wyse";

    # Enables DHCP on each ethernet & wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;

    #interfaces.enp0s13f0u2c2.useDHCP = lib.mkDefault true;
    #interfaces.wlp166s0.useDHCP = lib.mkDefault true;
  };

  console.useXkbConfig = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = "performance";
  system.stateVersion = "23.11"; # Did you read the comment?
  users.users.${user} = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = ["wheel" "users" "dialout"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH ${user}@fw"
    ];
    #initialPassword = "nixos-installer-changeme";
  };
  qt.enable = true;
  nix.settings.trusted-public-keys = ["hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="];
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
    chromium = {
      enable = true;
      defaultSearchProviderEnabled = true;
    };
    #firefox.enable = true;
    gnupg = {
      dirmngr.enable = true;
      agent.enableExtraSocket = true;
      agent.enableBrowserSocket = true;
    };
  };
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
}
