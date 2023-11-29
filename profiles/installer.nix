{ inputs
, config, lib, pkgs
, user
, modulesPath
, ...
}:
let
  targetIP = "192.168.1.251";
  nixos-anywhere-script = ''
    # --- On target machine ---
    passwd
    ip addr
    wait 10

    # --- From remote machine ---
    # Test SSH connection
    ssh -v nixos@${targetIP}

    # Run NixOS anywhere
    nix run github:nix-community/nixos-anywhere -- --flake '.#${config.networking.hostName}' nixos@${targetIP}

  '';

in
{
  imports = [
    inputs.disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    #./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    initrd.kernelModules = ["nvme"];
    kernelModules = ["kvm-intel"];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = ["btrfs"];
    tmpOnTmpfs = true;
  };

  disko.enableConfig = lib.mkDefault false;

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake" "recursive-nix" "ca-derivations"];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    nixPath = ["nixpkgs=${pkgs.path}"];
  };

  services.openssh = {
    enable = true;
    extraConfig = ''
      MaxAuthTries 600
    '';
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      ${user} = {
        shell = pkgs.zsh;
        extraGroups = ["wheel" "networkmanager"];
        openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw"];
      };
      nixos.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw"];
      root = {
        openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw"];
        initialPassword = "nixos-installer-changeme";
      };
    };
  };

  environment.sessionVariables.EDITOR = "nvim";
  environment.shells = [pkgs.bash pkgs.zsh];
  environment.systemPackages = let
    disko = pkgs.writeShellScriptBin "disko" ''${config.system.build.disko}'';
    disko-mount = pkgs.writeShellScriptBin "disko-mount" "${config.system.build.mountScript}";
    disko-format = pkgs.writeShellScriptBin "disko-format" "${config.system.build.formatScript}";
    install-system = pkgs.writeShellScriptBin "install-system" ''
      set -euo pipefail
      echo "Formatting disks..."
      . ${disko-format}/bin/disko-format && echo "Formatted disk." || echo "Format failed!"
      echo "Mounting disks..."
      . ${disko-format}/bin/disko-mount && echo "Mounted." || echo "Mount failed!"
      echo "Installing system..."
      nixos-install --system ${inputs.self.nixosConfigurations.${host}.config.system.build.toplevel} \
        && echo "Done!" \
        || echo "Installation failed. :("
    '';
  in (with inputs.disko.packages.${pkgs.system}; [disko disko-doc]) ++ (with pkgs; [
    bat bottom curl diskrsync dnsutils fd fzf git helix htop httpie jq lsd neofetch neovim ntfsprogs ntfs3g procs ripgrep wget zsh
  ]) ++ [disko disko-mount disko-format];

  system.stateVersion = "23.11";

  # --- NixOS-Anywhere Process ---
  # passwd
}

# --- Other Install Steps ----------------------------------
#
# - Enable SSH
#   - Set password: `passwd`
#   - Get IP address: `ip addr`
#
# - Generate on target machine:
#   - `/etc/nixos/hardware-configuration.nix` (`nixos-generate-config --no-filesystems --root /mnt`)
#   - `/etc/machine-id`
#   - `/etc/hostname`
#   - `/etc/ssh/ssh_host_rsa_key`     & `/etc/ssh/ssh_host_ed25519_key`
#   - `/etc/ssh/ssh_host_rsa_key.pub` & `/etc/ssh/ssh_host_ed25519_key.pub`
#
# - Generate configs for target machine:
#   - hosts/<name>/secrets/default.yaml
#   - hosts/<name>/hardware-configuration.nix (`nixos-generate-config` on target)
#   - hosts/<name>/disko.nix                  (copy & edit from existing)
#
