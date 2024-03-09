{ inputs, lib, pkgs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    agenix
    arion
    envfs
    flake-utils-plus
    home-manager
    lanzaboote

    # https://github.com/nix-community/nixos-generators
    # nix build .#nixosConfigurations.<host>.config.formats.<format>
    nixos-generators

    nixvim
    nur
    sops

    ##./colmena.nix
    ##./disko.nix
    ##./impermanence.nix
    ##./microvm.nix
    ##./nix-index.nix
    ##./nixified-ai.nix
    ##./nixos-generators.nix
    ##./nixos-images.nix
    ##./quick-nix-registry.nix

    #colmena.nixosModules.assertionModule
    #colmena.nixosModules.deploymentOptions
    #colmena.nixosModules.keyChownModule
    #colmena.nixosModules.keyServiceModule
    #colmena.nixosModules.metaOptions

    #nixified-ai.nixosModules.invokeai
    #nixified-ai.nixosModules.textgen

    # https://github.com/polygon/scalpel
    # TODO: Create lib to wrap nixosConfigurations & disable here
    inputs.scalpel.nixosModules.scalpel

    # https://github.com/nix-community/srvos
    inputs.srvos.nixosModules.common # # desktop, server,   mixins-terminfo,     mixins-tracing,
    inputs.srvos.nixosModules.mixins-nix-experimental # # mixins-cloud-init, mixins-systemd-boot, mixins-telegraf
    inputs.srvos.nixosModules.mixins-trusted-nix-caches # roles-github-actions-runner, roles-nix-remote-builder
  ];

  #formatConfigs = {
  #  install-iso = {};
  #};
}
