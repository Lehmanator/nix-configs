{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ./wine.nix
  ];

}
