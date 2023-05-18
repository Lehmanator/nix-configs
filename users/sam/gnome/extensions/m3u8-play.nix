{ self, inputs,
  config, lib, pkgs,
  ...
}: {

  home.packages = [
    pkgs.gnomeExtensions.m3u8-play
  ];

}
