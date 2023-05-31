{ self, inputs, config, lib, pkgs, ... }: {
  imports = [
    ./editorconfig.nix
    ./helix
    ./neovim.nix
  ];
}
