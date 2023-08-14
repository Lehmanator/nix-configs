{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  environment.systemPackages = [
    pkgs.usbutils
  ];
}
