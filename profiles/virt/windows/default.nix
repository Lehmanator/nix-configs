{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ./vm.nix
    ./wine.nix
  ];

}
