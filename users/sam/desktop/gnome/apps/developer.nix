{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
{
  imports = [
    ./dbus.nix
  ];

  home.packages = [
    pkgs.blackbox-terminal
    pkgs.cambalache
    pkgs.gnome-builder
    pkgs.gnome-doc-utils
    pkgs.gnome.dconf-editor
    pkgs.gnome.devhelp
    pkgs.gnome.ghex
    pkgs.gnome.zenity

  ];
}
