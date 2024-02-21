{inputs, ...}: {
  # TODO: Organize into profiles, modules, shells
  imports = [
    inputs.devshell.flakeModule
    #../shells/base.nix
    #../shells/common.nix
    ../shells/git.nix
    #../shells/nix.nix
    ../shells/nixos.nix
    #../shells/rust.nix
  ];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    devShells.default = config.devShells.nixos;
  };
}
