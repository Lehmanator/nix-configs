{ self, inputs, lib, config, pkgs, ... }:
{

  imports = [
    ./chat.nix
    ./office.nix
  ];

  home.packages = [
    pkgs.bitwarden
  ];

}
