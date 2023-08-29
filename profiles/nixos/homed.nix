{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  services.homed.enable = true;
}
