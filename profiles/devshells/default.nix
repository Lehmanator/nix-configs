{ inputs, ... }: {
  # TODO: Organize into profiles, modules, shells
  imports = [
    inputs.devshell.flakeModule
    #./base.nix
    #./common.nix
    ./git.nix
    #./nix.nix
    #./rust.nix
  ];
  perSystem = { config, lib, pkgs, ... }:
    {
      #devshells.default = config.devshells.nixos;
    };
}
