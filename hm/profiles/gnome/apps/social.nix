{ inputs, config, lib, pkgs, ... }:
#
# See: [../../../docs/packages/social-apps.md](../../../docs/packages/social-apps.md)
# TODO: Differentiate between chat & social apps?
#
let
  prefer-flatpak = true;
in
{
  home.packages = lib.mkIf (! prefer-flatpak) [
    # --- Fediverse --------------------------------------------------
    pkgs.tuba             # Mastodon (GTK4)
    pkgs.element-desktop  # Matrix   (Electron)
    pkgs.element-call     # Matrix   (Electron)
    pkgs.cinny-desktop    # Matrix   (Electron)
    pkgs.hydrogen-web     # Matrix   (Electron?)
    pkgs.fluffychat       # Matrix   (Flutter)

    # --- Unfree Platforms -------------------------------------------
    pkgs.dissent          # Discord  (GTK4)
    pkgs.headlines        # Reddit   (GTK4)
    pkgs.paper-plane      # Telegram (GTK4)
    pkgs.telegram-desktop # Telegram (Electron)
    pkgs.chatterino2      # Twitch

    # --- Misc -------------------------------------------------------
    pkgs.tangram          # Web Apps (GTK4)
  ];

  services.flatpak.packages = [
    { origin="flathub";      appId="/io.github.libredirect.frontends-manager"; }
    { origin="flathub";      appId="ml.mdwalters.Lemonade";     } # Lemmy    (GTK4)
    { origin="flathub";      appId="net.codelogistics.webapps"; } # Web Apps (GTK4)
  ] ++ lib.optionals prefer-flatpak [

    # --- Fediverse --------------------------------------------------
    # --- Mastodon ------
    { origin="flathub";      appId="dev.geopjr.Tuba";          } # Mastodon (GTK4)
    # --- Matrix --------
    # https://flathub.org/apps/com.github.quaternion
    # https://flathub.org/apps/xyz.mx_moment.moment
    # https://flathub.org/apps/org.syphon.Syphon
    # https://flathub.org/apps/im.nheko.Nheko
    # https://flathub.org/apps/org.eu.encom.spectral
    # https://flathub.org/apps/chat.quadrix.Quadrix
    # { origin="flathub";    appId="org.kde.neochat";                } # Matrix (Qt) 
    # { origin="gnome-nightly"; appId="org.gnome.Fractal.Devel";     } # Matrix (GTK4)
    { origin="flathub";      appId="org.gnome.Fractal";              } # Matrix (GTK4)
    { origin="flathub";      appId="im.riot.Riot";                   } # Matrix (Electron)
    { origin="flathub";      appId="in.cinny.Cinny";                 } # Matrix (Electron)
    { origin="flathub";      appId="chat.schildi.desktop";           } # Matrix (Electron)
    { origin="flathub";      appId="im.fluffychat.Fluffychat";       } # Matrix (flutter)

    # --- Unfree Platforms -------------------------------------------
    { origin="flathub-beta"; appId="app.drey.PaperPlane";            } # Telegram (GTK4)
    { origin="flathub";      appId="so.libdb.dissent";               } # Discord  (GTK4)
    { origin="flathub";      appId="io.gitlab.caveman250.headlines"; } # Reddit   (GTK4)
    { origin="flathub";      appId="net.krafting.Reddy";             } # Reddit -> Lemmy (GTK4)
    { origin="flathub";      appId="com.chatterino.chatterino";      } # Twitch

    # --- Misc -------------------------------------------------------
    { origin="flathub";     appId="re.sonny.Tangram"; }
  ];

  # # https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys
  # # TODO: mkReverseDNS = url:
  # xdg.desktopEntries."com.snapchat.Snapchat" = {
  #   name = "Snapchat";
  #   comment = "Talk to friends on Snapchat";
  #   # http://freedesktop.org/wiki/Standards/icon-theme-spec
  #   icon = "";
  #   # http://www.freedesktop.org/Standards/menu-spec
  #   categories = ["Application" "Network" "WebApp"];
  #   terminal = false;
  #   type = "Application";
  #   # https://specifications.freedesktop.org/desktop-entry-spec/latest/exec-variables.html
  #   exec = "flatpak run net.codelogistics.webapps ${appId}";
  #   mimeType = [];
  #   # http://www.freedesktop.org/Standards/startup-notification-spec
  #   startupNotify = false;
  #   # https://specifications.freedesktop.org/desktop-entry-spec/latest/recognized-keys.html
  #   settings = {
  #     NoDisplay = false;
  #     # Only used if Type == "Link"
  #     URL = "";
  #     # Compares to $XDG_CURRENT_DESKTOP
  #     NotShowIn = "phosh";
  #     OnlyShowIn = "gnome,plasma";
  #     Keywords = "calc;math";
  #     # https://specifications.freedesktop.org/desktop-entry-spec/latest/dbus.html
  #     DBusActivatable = "false";
  #     # https://specifications.freedesktop.org/desktop-entry-spec/latest/interfaces.html
  #     #  Comma-sep strings
  #     Implements="";
  #     # http://www.freedesktop.org/Standards/startup-notification-spec
  #     StartupWMClass = "";
  #   };
  #   # https://specifications.freedesktop.org/desktop-entry-spec/latest/extra-actions.html
  #   # actions."New Window" = {
  #   #   exec = "${pkgs.firefox}/bin/firefox --new-window %u";
  #   # };
  # };
}
