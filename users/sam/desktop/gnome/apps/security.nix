{ self, inputs, config, lib, pkgs,
  ...
}:
{
  imports = [
    ./vaults.nix
  ];

  home.packages = [
    pkgs.authenticator
    pkgs.gnome-keysign
    pkgs.gnome-secrets

  ];
}
