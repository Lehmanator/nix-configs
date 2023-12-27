{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./agenix.nix
    ./arion.nix
    #./colmena.nix
    ./declarative-flatpak.nix
    #./disko.nix
    ./envfs.nix
    ./flake-utils-plus.nix
    ./home-manager.nix
    #./impermanence.nix
    ./lanzaboote.nix
    #./microvm.nix
    #./nix-index.nix
    #./nixified-ai.nix
    ./nixos-generators.nix
    #./nixos-images.nix
    ./nixvim.nix
    ./nur.nix
    ./quick-nix-registry.nix
    ./scalpel.nix
    ./sops.nix
    ./srvos.nix

    #inputs.nixified-ai.nixosModules.invokeai
    #inputs.nixified-ai.nixosModules.textgen
  ];
}
