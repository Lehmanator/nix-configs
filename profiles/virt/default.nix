{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    ./android
    ./containers
    ./vm
    ./wine.nix
  ];

}
