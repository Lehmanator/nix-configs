{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    ./android
    ./containers.nix
    ./vm
    ./wine.nix
  ];

}
