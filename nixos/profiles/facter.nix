{ inputs, config, lib, pkgs, ... }:
{
  # https://github.com/nix-community/nixos-facter-modules
  # https://github.com/nix-community/nixos-facter
  # https://nix-community.github.io/nixos-facter/latest/
  # nixos-facter-modules - 
  imports = [inputs.facter.nixosModules.facter];
  facter.reportPath = inputs.self + /nixos/hosts/${config.networking.hostName}/facter.json;

  # $ sudo nix run nixpkgs#nixos-facter -- -o facter.json
  environment.systemPackages = [
    pkgs.nixos-facter
    (pkgs.writeShellApplication {
      name = "facter";
      runtimeInputs = [pkgs.nixos-facter];
      text = ''
        nixos-facter -o nixos/hosts/${config.networking.hostName}/facter.json
      '';
    })
  ];
}
