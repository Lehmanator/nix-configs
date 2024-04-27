{ inputs, config, lib, pkgs, user, ... }:
{
  # https://github.com/nix-community/nixos-generators
  #
  # nix build .#nixosConfigurations.<host>.config.formats.<format>
  imports = [ inputs.nixos-generators.nixosModules.all-formats ];

  formatConfigs = {
    # TODO: Disable documentation, dev packages
    install-iso = {
      #config, lib, ... }: {
      boot.loader.timeout = lib.mkForce 10;
      networking = {
        networkmanager.enable = lib.mkForce false;
        useDHCP = lib.mkForce false;
      };
      security.sudo-rs.enable = lib.mkForce false;
      services.openssh.extraConfig = ''
        MaxAuthTries 600
      '';
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
