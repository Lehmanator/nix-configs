{ inputs, config, lib, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Visual_Studio_Code
  # TODO: Use VSCodium
  # TODO: Add extensions
  # TODO: Add FOSS extension marketplace
  imports = [
    inputs.nix-vscode-ide.homeManagerModules.default
    inputs.nix-vscode-extensions.homeManagerModules.default
  ];

}
