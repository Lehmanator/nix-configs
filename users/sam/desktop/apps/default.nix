{ self, inputs, lib, config, pkgs, ... }:
{

  imports = [
    ./browsers.nix
    ./chat.nix
    ./games
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
