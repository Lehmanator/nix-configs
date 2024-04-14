{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.modem-broadband-provider-info
    pkgs.modem-manager-gui
    pkgs.pidginPackages.purple-mm-sms
  ] ++ lib.optionals config.gtk.enable [ pkgs.chatty ];

  #services.flatpak.packages = [
  #] ++ lib.optionals config.gtk.enable [
  #  "flathub:app/sm.puri.Chatty//stable"
  #  "flathub:app/org.gnome.Calls//stable"
  #  "gnome-nightly:app/org.gnome.Calls//master"
  #];

  # TODO: Protocol handler strings for: sms, xmpp, matrix?
}
