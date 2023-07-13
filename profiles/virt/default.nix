{ inputs, self
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
    ./vm-host.nix
  ];

}
