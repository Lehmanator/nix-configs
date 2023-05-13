{ self, inputs, config, lib, pkgs,
  ...
}:
{
  home.packages = [
    pkgs.authenticator
  ];
}
