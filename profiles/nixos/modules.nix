{ inputs, lib, pkgs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    agenix
    arion
    flake-utils-plus
    home-manager
    lanzaboote
    nixvim
    sops

    #./agenix.nix
    #./arion.nix
    #./flake-utils-plus.nix
    #./home-manager.nix
    #./lanzaboote.nix
    #./nixvim.nix
    #./sops.nix

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

    inputs.declarative-flatpak.nixosModules.declarative-flatpak
    inputs.envfs.nixosModules.envfs

    # https://github.com/nix-community/nixos-generators
    # nix build .#nixosConfigurations.<host>.config.formats.<format>
    inputs.nixos-generators.nixosModules.all-formats

    inputs.nur.nixosModules.nur

    #nixified-ai.nixosModules.invokeai
    #nixified-ai.nixosModules.textgen

    # https://github.com/polygon/scalpel
    inputs.scalpel.nixosModules.scalpel

    # https://github.com/nix-community/srvos
    inputs.srvos.nixosModules.common # # desktop, server,   mixins-terminfo,     mixins-tracing,
    inputs.srvos.nixosModules.mixins-nix-experimental # # mixins-cloud-init, mixins-systemd-boot, mixins-telegraf
    inputs.srvos.nixosModules.mixins-trusted-nix-caches # roles-github-actions-runner, roles-nix-remote-builder
  ];

  home-manager.sharedModules = with inputs; [
    declarative-flatpak.homeManagerModules.declarative-flatpak
    nur.hmModules.nur
  ];

  services.envfs.enable = lib.mkDefault true;

  #formatConfigs = {
  #  install-iso = {};
  #};
}
