{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./vaults
  ];

  home.packages = [
    pkgs.authenticator
    pkgs.gnome-keysign
    pkgs.gnome-secrets

  ];
}
