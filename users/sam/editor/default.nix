{ self, inputs, config, lib, pkgs, ... }: {
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.nano
    ./editorconfig.nix
    ./helix
    ./neovim
  ];
}
