{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
{
  imports = [
    ./dbus.nix
  ];

  home.packages = [
    pkgs.cambalache
    pkgs.gnome-builder
  ];
}
