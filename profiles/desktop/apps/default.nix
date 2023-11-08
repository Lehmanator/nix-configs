{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ./libreoffice.nix
  ];

  programs.fuse.userAllowOther = true;

  environment.systemPackages = [
    pkgs.fuse3
    pkgs.fuse-common

    pkgs.thunderbird
  ];

}
