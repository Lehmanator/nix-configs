{ inputs, self
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
    ./android
    ./containers.nix
    ./vm-host.nix
  ];

}
