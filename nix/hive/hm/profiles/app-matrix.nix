{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.element-desktop
    #pkgs.cinny-desktop
    #pkgs.schildichat
    pkgs.pidginPackages.purple-matrix
  ] ++ lib.optionals config.gtk.enable [
    pkgs.chatty
    pkgs.fractal
    #pkgs.fractal-next
  ];

  #services.flatpak.packages = [
  #  "flathub:app/im.riot.Riot//stable"
  #  "flathub:app/im.riot.Riot//stable"
  #  "flathub:app/chat.schildi.desktop//stable"
  #  "flathub:app/io.github.NhekoReborn.Nheko//stable"
  #  "flathub:app/in.cinny.Cinny//stable"
  #] ++ lib.optionals config.gtk.enable [
  #  #"flathub:app/org.gnome.Fractal//stable"
  #  #"flathub-beta:app/org.gnome.Fractal//beta"
  #  "gnome-nightly:app/org.gnome.Fractal.Devel//master"
  #];
}
