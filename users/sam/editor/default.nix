{ self, inputs, config, lib, pkgs, ... }: {
  imports = [
    ./editorconfig.nix
    ./helix.nix
    ./neovim.nix
  ];
}
