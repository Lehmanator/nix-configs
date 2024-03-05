{ inputs, ... }: {
  # TODO: Organize into profiles, modules, shells
  imports = [
    inputs.devshell.flakeModule
    #../profiles/devshells/base.nix
    #../profiles/devshells/common.nix
    #../profiles/devshells/nix.nix
    #../profiles/devshells/rust.nix
    ../devshells/git.nix
  ];
  perSystem = { config, lib, pkgs, ... }:
    {
      #devShells.default = config.devShells.nixos;
    };
}
