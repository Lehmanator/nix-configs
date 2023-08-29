{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./borders.nix
    ./symbols.nix
    ./windows.nix
  ];

}
