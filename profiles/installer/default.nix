{ config, lib, pkgs, modulesPath, ... }:
{
  # https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
  # https://nixos.org/manual/nixos/stable/index.html#sec-building-image
  # nix build .#<configName>.config.system.build.isoImage
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      extra-features = [ "nix-channel" "flakes" "repl-flake" ];
    };
  };

  # Faster build (at expense of iso size)
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  # --- SSH ---
  services.openssh = {
    enable = true;
    extraConfig = ''
      MaxAuthTries 600
    '';
  };
  users.users.root = {
    initialPassword = "changeme-nixos-installer";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw" ];
  };


  # --- Bootloader, initrd, & Kernel ---
  boot = {

    # Detect hardware at boot.
    hardwareScan = true;

    # NVMe kernel modules
    # BTRFS kernel modules & pkgs; [btrfs btrfs-progs];
    #extraModulePackages = [];

    # Use latest Linux kernel
    kernelPackages = pkgs.linuxPackages_latest; # TODO: Consider pkgs.linux_zen ?
    kernelModules = [ "fuse" "kvm-intel" "coretemp" ];
    kernelParams = [
      # Fix NVMe drive regression preventing it from being detected
      "nvme_core.default_ps_max_latency_us=0" #"nvme_core.default_ps_max_latency_us=5500"
      "pcie_aspm=off"
    ];
    # TODO: initrd secrets? SSH in initrd? LUKS keys?
    initrd = {
      availableKernelModules = [ "sdhci_pci" "nvme" "btrfs" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      includeDefaultModules = true;
      kernelModules = [ ];
      supportedFilesystems = [ "btrfs" "vfat" "f2fs" ];
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi"; # Default: `/boot`  # TODO: `XBOOTLDR` / `ESP` splitting. # TODO: Rewrite to `/efi`?
      };

      grub.enable = lib.mkForce false; # Disable GRUB & conditionally systemd-boot
      systemd-boot.enable = config.boot ? lanzaboote; # Only use systemd-boot if we don't have lanzaboote for SecureBoot
    };
  };

  # --- Features -------------------------------------------
  # --- Zram Swap ---
  # https://www.kernel.org/doc/Documentation/blockdev/zram.txt
  zramSwap = { enable = true; algorithm = "zstd"; };

  # --- Shell environment ---
  environment = {
    sessionVariables.EDITOR = "nvim";
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = [
      pkgs.bat
      pkgs.fd
      pkgs.fzf
      pkgs.git
      pkgs.neovim
      pkgs.neofetch
      pkgs.lsd
      pkgs.eza
    ];
  };

  system.stateVersion = "23.11";
}
