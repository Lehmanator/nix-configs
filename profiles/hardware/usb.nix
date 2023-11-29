{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  environment.systemPackages = [
    pkgs.usbutils
  ];
}
