{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.fuse.userAllowOther = true;

  environment.systemPackages = [
    pkgs.fuse3
    pkgs.appimagekit
  ];
}
