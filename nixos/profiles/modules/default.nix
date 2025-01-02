{ inputs, lib, config, pkgs, ... }:
{
  imports = with inputs; [
    # ./flake-utils-plus.nix
    #./microvm.nix
    #./nix-index.nix
    #./nixified-ai.nix
    #./nixos-generators.nix
    #./nixos-images.nix
    #./quick-nix-registry.nix

    #colmena.nixosModules.assertionModule
    #colmena.nixosModules.deploymentOptions
    #colmena.nixosModules.keyChownModule
    #colmena.nixosModules.keyServiceModule
    #colmena.nixosModules.metaOptions
    envfs.nixosModules.envfs
    # https://github.com/nix-community/nixos-generators
    # nix build .#nixosConfigurations.<host>.config.formats.<format>
    nixos-generators.nixosModules.all-formats
    #nixified-ai.nixosModules.invokeai
    #nixified-ai.nixosModules.textgen
    # https://github.com/polygon/scalpel
    # scalpel.nixosModules.scalpel

    # https://github.com/nix-community/srvos
    # srvos.nixosModules.common #                  # desktop, server,   mixins-terminfo,     mixins-tracing,
    # srvos.nixosModules.mixins-nix-experimental # NOTE: Broken setting: experimental-features = ["configurable-impure-env"]
    # mixins-cloud-init, mixins-systemd-boot, mixins-telegraf
    srvos.nixosModules.mixins-trusted-nix-caches # roles-github-actions-runner, roles-nix-remote-builder
  ];

  services.envfs.enable = lib.mkDefault true;

  #formatConfigs = {
  #  install-iso = {};
  #};

}
