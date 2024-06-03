{ pkgs, ... }: {
  programs.gnome-shell.extensions = [{
    package = pkgs.gnomeExtensions.tophat;
  }];

  # Make deps available.
  # TODO: Check if working properly
  home.packages = [
    pkgs.gtop
    pkgs.libgtop
  ];

  # TODO: Dconf settings
}
