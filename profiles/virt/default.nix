{ inputs, self
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
    ./containers.nix
    ./vm-host.nix
  ];

}
