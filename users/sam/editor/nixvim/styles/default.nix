{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./border.nix
    ./symbols.nix
    ./windows.nix
  ];

}
