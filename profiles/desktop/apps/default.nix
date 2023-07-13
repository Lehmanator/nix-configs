{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ./libreoffice.nix
  ];

  environment.systemPackages = [
    pkgs.thunderbird
  ];

}
