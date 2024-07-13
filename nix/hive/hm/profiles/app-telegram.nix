{ pkgs, config, lib, ... }: {
  home.packages = [
    pkgs.tg # Terminal client for Telegram
    pkgs.tdlib # Telegram CLI lib
    pkgs.nchat # Terminal client for Telegram & WhatsApp
    # pkgs.pidginPackages.tdlib-purple # Pidgin/libpurple Telegram plugin using tdlib
    pkgs.kotatogram-desktop # Experimental Telegram UI
    pkgs.telegram-desktop # Upstream Telegram electron client
  ] 
  ++ lib.optional config.gtk.enable pkgs.paper-plane
  ;

  services.flatpak.packages = [{appId="org.telegram.desktop"; }]
    ++ lib.optional config.gtk.enable { appId = "app.drey.PaperPlane"; };
}
