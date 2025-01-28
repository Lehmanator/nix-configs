{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  imports = [
    inputs.flake-utils-plus.nixosModules.autoGenFromInputs
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.nur.modules.nixos.default
    inputs.scalpel.nixosModules.scalpel
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
    (inputs.self + /nixos/profiles/adb.nix)
    (inputs.self + /nixos/profiles/agenix.nix)
    (inputs.self + /nixos/profiles/bash.nix)
    (inputs.self + /nixos/profiles/home-manager.nix)
    (inputs.self + /nixos/profiles/locale-est.nix)
    (inputs.self + /nixos/profiles/mobile)
    (inputs.self + /nixos/profiles/nix)
    (inputs.self + /nixos/profiles/nixvim)
    (inputs.self + /nixos/profiles/sops.nix)
    (inputs.self + /nixos/profiles/sshd.nix)
    (inputs.self + /nixos/profiles/user-primary.nix)
    (inputs.self + /nixos/profiles/zsh.nix)
  ];

  # home-manager = {
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   verbose = true;
  #   extraSpecialArgs = { inherit inputs user; };
  #   sharedModules = [
  #     inputs.nix-flatpak.homeManagerModules.nix-flatpak
  #     inputs.nixvim.homeManagerModules.nixvim
  #     inputs.nur.modules.homeManager.default
  #   ];
  #   users.${user} = import (inputs.self + /hm/users/${user});
  # };

  sops = {
    defaultSopsFile = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets/default.yaml;
    age.sshKeyPaths = map (k: k.path) (builtins.filter (k: k.type == "ed25519") config.services.openssh.hostKeys);
    secrets = {github-token = {};};
  };

  services.flatpak = {
    enable = true;
    # packages = [];
    overrides = {
      global.filesystems = lib.mkDefault [
        "xdg-config:gtk-4.0:ro"
        "xdg-config:gtk-3.0:ro"
        "xdg-config:gtk-2.0:ro"
      ];
    };
  };

  nix = {
    generateRegistryFromInputs = true;
    generateNixPathFromInputs = true;
    linkInputs = true;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  appstream.enable = true;
  networking.hostName = "fajita";
  system.stateVersion = "23.11";

  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    password = "545352";
    extraGroups = [
      "dialout"
      "feedbackd"
      "networkmanager"
      "video"
      "wheel"
      "gdm"
      "flatpak"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH ${user}@fw"
    ];
  };

  services.openssh.enable = true;
  # services.pipewire.enable = false;
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    sensor.iio.enable = true;
    enableRedistributableFirmware = true;
  };
  nixpkgs = {
    config = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
    hostPlatform = "aarch64-linux";
    overlays = [inputs.fenix.overlays.default inputs.nur.overlays.default];
  };
  # nix.registry.self = inputs.self.outPath;
  environment.etc."nix/inputs/self".source = inputs.self.outPath;

  # Reset IM_MODULE to fix on-screen keyboard
  environment.variables = {
    GTK_IM_MODULE = lib.mkForce "";
    QT_IM_MODULE = lib.mkForce "";
    XMODIFIERS = lib.mkForce "";
  };

  mobile.enable = true;
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.phosh.enable = false;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.mutter.dynamic-workspaces]
        enabled=true
      '';
      extraGSettingsOverridePackages = [pkgs.gnome.mutter];
    };
  };
  programs.calls.enable = true;
}
