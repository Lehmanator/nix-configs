{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./home.nix
    ./work.nix
  ];


}
