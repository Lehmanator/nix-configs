{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    #./settings.nix
  ];

  home.packages = [
    pkgs.gnomeExtensions.m3u8-play
  ];

}
