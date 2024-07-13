{ inputs, cell, self, super, }@args:
let
  inherit (super.bee) home pkgs;
  inherit (pkgs) lib;
  modules = with inputs.omnibus.flake.inputs; [
    home.nixosModules.home-manager
    cell.nixosModules.debug
    # cell.nixosModules.tailscale-autoconnect

    # inputs.cells.android.nixosModules.attestation-server

    # agenix.nixosModules.age
    # arion.nixosModules.arion
    disko.nixosModules.default
    microvm.nixosModules.host
    nixos-hardware.nixosModules.framework-12th-gen-intel
    ragenix.nixosModules.age
    # snapshotter.nixosModules.default #containerd k3s nix-snapshotter preload-containerd (all have -rootless versions)
    # sops-nix.nixosModules.sops
    srvos.nixosModules.desktop
    # srvos.nixosModules.server
    srvos.nixosModules.mixins-nginx
    srvos.nixosModules.mixins-nix-experimental
    srvos.nixosModules.mixins-systemd-boot
    # srvos.nixosModules.mixins-telegraf
    srvos.nixosModules.mixins-terminfo
    srvos.nixosModules.mixins-tracing
    srvos.nixosModules.mixins-trusted-nix-caches
    # srvos.nixosModules.roles-github-actions-runner
    # srvos.nixosModules.roles-nix-remote-builder
    # srvos.nixosModules.roles-prometheus
    
    inputs.nixos-generators.nixosModules.all-formats
    # inputs.nur.nixosModules.nur
  ];
  profiles = with cell.nixosProfiles; [
    # acme
    # activation-base
    # activitywatch
    adb
    apparmor
    arion
    auditd
    appimage
    bluetooth
    cachix-agent
    containerd
    cri-o
    desktop
    # disk-utils
    display-base
    docker
    emu-architectures
    # envfs
    # flatpak
    # firewall
    # fonts
    fprintd
    fwupd
    gtk
    gnome
    hercules-ci
    homed
    locale-est
    lxc # apparmor
    lxd
    motd
    networking-base # firewall dns-base networkmanager tailscale tailscale-mullvad-exit-node wifi wifi-hotspot wireguard
    # nixos-generators
    # nixos-images
    normalize
    nur
    nushell
    ollama
    peripherals-apple
    peripherals-logitech
    # peripherals-printers
    # peripherals-scanners
    pipewire
    plymouth
    # polkit
    # power-management
    printing
    qemu
    resolvconf
    sops
    sshd
    # stylix
    sudo-rs
    systemd-boot
    systemd-initrd
    # tailscale
    # tailscale-mullvad-exit-node
    thunderbolt
    tpm2
    usb
    wireguard
    #user-primary peripherals-printers peripherals-scanners server-k3s-node-main ssbm-nix
    # fprintd #../..profiles/common/editor # DISABLED
    #../../profiles/(nixos nixos/boot.nix nixos/security.nix nixos/virt.nix)
  ];
in
{
  inherit (super) bee;
  system.stateVersion = super.meta.stateVersion;
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    };
    kernelModules = [ "kvm-intel" ];
    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };
  console.useXkbConfig = true;
  environment = {
    etc.machine-id.text = "aa38a832d16e436d8aab8bb0550d4810";
  };
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault true;
    enableAllFirmware = true;
    enableRedistributableFirmware = lib.mkDefault true;
    sensor.iio.enable = true;
  };
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = super.specialArgs;
    sharedModules = [{_module.args = super.specialArgs;}];
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    users.sam = super.homeConfiguration; #import super.homeConfiguration args;
  };
  networking = {
    hostName = "fw";
    useDHCP = lib.mkDefault true;
  };
  nix.settings.extra-trusted-public-keys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  programs = {
    git = { enable = true; package = pkgs.gitFull; };
    traceroute.enable = true;
  };
  qt.enable = true;
  users.users.sam = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];
  };

  imports = pkgs.lib.flatten [
    { _module.args = super.specialArgs; }
    { imports = [ ./hardware-configuration.nix ] ++ profiles; }
  ] ++ modules;
}
