{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  home.packages = [
    pkgs.phosh-mobile-settings
  ];
}
