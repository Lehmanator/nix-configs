{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../vm-host.nix
  ];

  environment.systemPackages = [
    pkgs.win-spice
  ];

}
