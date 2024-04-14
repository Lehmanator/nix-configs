{
  inputs,
  cell,
  ...
}: {
  imports = [
    (import (inputs.hive + /src/beeModule.nix) {inherit (inputs) nixpkgs;})
  ];

  bee = {
    system = "x86_64-linux";
    home = inputs.home-manager;
    #wsl = inputs.nixos-wsl;
    darwin = inputs.darwin;
    pkgs = inputs.nixpkgs;
  };
}
