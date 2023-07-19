{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./host.nix
  ];

  environment.systemPackages = [
    pkgs.win-spice
  ];

}
