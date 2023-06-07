{ self, inputs, lib, config, pkgs, ... }:
{

  imports = [
    ./browsers.nix
    ./chat.nix
    #./games.nix
    ./office.nix
    ./social.nix
    ./bitwarden
    #./chromium
    #./firefox
  ];

  home.packages = [
    pkgs.bitwarden
  ];

}
