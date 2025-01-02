{ inputs, lib, config, pkgs, ... }:
{
  imports = with inputs; [
    # ./flake-utils-plus.nix
    #./microvm.nix
    #./nix-index.nix
    #./nixos-images.nix
    #./quick-nix-registry.nix

    #./nixified-ai.nix
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

}
