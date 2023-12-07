{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
{
  imports = [
    ./dbus.nix
  ];

  home.packages = [
    pkgs.blackbox-terminal       # GTK4 terminal application
    pkgs.cambalache              #
    pkgs.gitg                    # Graphical Git client
    pkgs.gnome-builder           # IDE for developing GNOME apps
    pkgs.gnome-doc-utils         # Documentation utils
    pkgs.gnome.dconf-editor      # Dconf setting editor
    pkgs.gnome.devhelp           # Developer documentation viewer
    pkgs.gnome.ghex              # GTK hex editor
    pkgs.gnome.zenity            #

    pkgs.elastic                 # Design spring animations
    pkgs.meld                    # Visual diff
  ];
}
