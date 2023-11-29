{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [
    ./android
    ./appimage.nix
    ./containers
    ./vm
    ./wine.nix
  ];

}
