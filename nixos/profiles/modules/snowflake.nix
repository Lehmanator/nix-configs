{ inputs, config, lib, pkgs, ... }:
{
  # https://github.com/snowfallorg/snowflakeos-modules/blob/main/modules/nixos/snowflakeos/default.nix
  imports = with inputs.snowflake-os.nixosModules; [
    snowflakeos
    # biosboot
    efiboot
    gnome
    kernel
    metadata
    networking
    packagemanagers
    pipewire
    printing
  ];
  modules = {
    efiboot.bootloader = "systemd-boot";
    gnome = {
      gsconnect.enable = true;
      removeUtils.enable = false;
    };
    packagemanagers.appimage.enable = true;
    pipewire.enable = true;
    snowflakeos = {
      nixSoftwareCenter.enable = true;
      nixosConfEditor.enable = true;
      snowflakeosModuleManager.enable = true;
      binaryCompat.enable = true;
    };
  };
  snowflakeos = {
    gnome.enable = true;
    # graphical.enable = true;
    osInfo.enable = true;
  };

  programs.nix-data = {
    # systemconfig = lib.mkDefault "/etc/nixos/nixos/hosts/${config.networking.hostName}/configuration.nix";
    flake = lib.mkDefault "/etc/nixos/flake.nix";
    flakearg = lib.mkDefault config.networking.hostName;
    generations = lib.mkDefault 50;
  };

  nixpkgs.overlays = [inputs.snowfall-flake.overlay];

  environment.systemPackages = [
    inputs.snowfall-flake.packages.${pkgs.system}.flake
  ];
}
