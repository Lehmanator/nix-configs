{ inputs
, self
, config
, lib
, pkgs
, user ? "sam"
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
