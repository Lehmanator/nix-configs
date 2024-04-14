{ inputs, lib, pkgs, ... }: {
  # https://github.com/nix-community/nixos-generators
  #
  # nix build .#nixosConfigurations.<host>.config.formats.<format>
  imports = [ inputs.nixos-generators.nixosModules.all-formats ];

  formatConfigs = {
    # TODO: Disable documentation, dev packages
    install-iso = {
      boot.loader.timeout = lib.mkForce 10;
      disko.enableConfig = lib.mkForce false;
      environment.systemPackages = with inputs.disko.packages.${pkgs.system}; [
        disko
        disko-doc
      ];
      networking = {
        networkmanager.enable = lib.mkForce false;
        useDHCP = lib.mkForce false;
      };
      nix = {
        package = pkgs.nixUnstable;
        settings.experimental-features =
          [ "nix-command" "flakes" "repl-flake" ];
      };
      security.sudo-rs.enable = lib.mkForce false;
      services.openssh = {
        enable = true;
        extraConfig = ''
          MaxAuthTries 600
        '';
      };
    };
    #  iso = { config, ... }: { };
    #  install-iso-hyperv = { config, ... }: { };
    #  docker = { config, ... }: { };
    #  kexec = { config, ... }: { };
    #  kexec-bundle = { config, ... }: { };
    #  kubevirt = { config, ... }: { };
    #  lxc = { config, ... }: { };
    #  lxc-metadata = { config, ... }: { };
    #  proxmox = { config, ... }: { };
    #  proxmox-lxc = { config, ... }: { };
    #  raw = { config, ... }: { };
    #  raw-efi = { config, ... }: { };
    #  sd-aarch64 = { config, ... }: { };
    #  sd-aarch64-installer = { config, ... }: { };
    #  vm = { config, ... }: { };
    #  vm-bootloader = { config, ... }: { };
    #  vm-nogui = { config, ... }: { };
    #  vmware = { config, ... }: { };
  };

  # TODO: Learn about `lib.extendModules`
}
