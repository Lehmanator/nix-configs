{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];
  #perSystem = { config, lib, pkgs, ... }: {
  #  devShells.default = config.devShells.nixos;
  #};
}
