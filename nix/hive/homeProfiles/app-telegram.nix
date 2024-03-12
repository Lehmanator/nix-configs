{ pkgs, config, lib, ... }: {
  home.packages = [
    pkgs.tg # Terminal client for Telegram
    pkgs.tdlib # Telegram CLI lib
    pkgs.nchat # Terminal client for Telegram & WhatsApp
    pkgs.pidginPackages.tdlib-purple # Pidgin/libpurple Telegram plugin using tdlib
    pkgs.kotatogram-desktop # Experimental Telegram UI
    pkgs.telegram-desktop # Upstream Telegram electron client
  ] ++ lib.optional config.gtk.enable pkgs.paper-plane;

  services.flatpak.packages = [ "flathub:app/org.telegram.desktop//stable" ]
    ++ lib.optionals config.gtk.enable
    [ "flathub-beta:app/app.drey.PaperPlane//beta" ];
}
