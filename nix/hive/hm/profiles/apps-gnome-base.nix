{ lib, pkgs, cell, ... }: {
  imports = with cell.homeProfiles; [
    # --- Distro-independent Apps ---
    # TODO: Import same category files from `../../apps` in `./<category>.nix`
    #../../apps
    apps-base

    apps-gnome-chat
    apps-gnome-dbus
    apps-gnome-developer
    apps-gnome-finance
    apps-gnome-multimedia
    apps-gnome-productive
    apps-gnome-reading
    apps-gnome-security
    apps-gnome-social
    apps-gnome-translate

    # --- Individual Apps ---
    # TODO: Move all apps to use dir structure: `./<appName>/{default,settings}.nix`
    # TODO: Use `./<category>.nix` to import these.
    gnome-app-calculator
    gnome-app-gradience
    gnome-app-valent
  ];

  # --- Install GTK4 Apps ---
  # TODO: Figure out apps loaded elsewhere & remove
  home.packages = with pkgs; [
    celeste # # Sync files w/ Google-Drive/Dropbox/Nextcloud/OwnCloud/WebDAV/OneDrive/S3
    czkawka # # Remove unnecessary files
    key-rack
    pika-backup # # Backup application
    warp # # QR code file transfer (https://gitlab.gnome.org/World/warp) TODO: Update
    #portfolio-filemanager  # Mobile-first file manager

    tangram # # Run web apps in tabbed app-like client

    gnome-extension-manager # Manage GNOME Shell extensions w/ search & install functionality
    dynamic-wallpaper # # Create dynamic wallpapers for GNOME
    #gradience #            # Theme GNOME, GTK, & various apps according to palettes or wallpapers
  ];

  # TODO: Package updated GNOME apps
  # https://gitlab.gnome.org/GNOME/gnome-system-monitor/-/merge_requests/55 # GNOME System Monitor w/ GTK4
  # TODO: Package new GNOME apps
  # https://flathub.org/apps/com.belmoussaoui.snowglobe #           # QEMU viewer over DBus  TODO: Package

  # https://flathub.org/apps/io.gitlab.gwendalj.package-transporter # Flatpak data backup & migration
  # https://github.com/flattool/warehouse #                         # Manage flatpak apps/data/remotes
  # https://github.com/tchx84/Flatseal #                            # Modify flatpak permissions/sandbox
  # https://gdm-settings.github.io/ #                               # Configure GDM login screen
  # https://github.com/kaii-lb/overskride #                         # Bluetooth config

  # https://gitlab.gnome.org/World/chess-clock #                    # Chess clock    TODO: Package
  # https://github.com/kra-mo/cartridges  #                         # Game launcher  TODO: Package

  # https://gitlab.gnome.org/philippun1/snoop #                     # App+Nautilus-ext: Search w/i files
  # https://github.com/mijorus/smile #                              # Emoji picker

  # https://bavarder.codeberg.page/ #                               # Multi-chatbot UI
  # https://codeberg.org/baarkerlounger/jogger #                    # Fitness tracker
  # https://apps.gnome.org/Impression/ #                            # USB flasher
  # https://flathub.org/apps/io.gitlab.daikhan.stable #             #

  # TODO: Package updated GNOME extensions
  # https://extensions.gnome.org/extension/5660/weather-or-not/ # (Updated to fix duplicate icon)
  #
  # TODO: Package new GNOME extensions
  # https://extensions.gnome.org/extension/5500/auto-activities/ # Show activities when no windows
  # https://extensions.gnome.org/extension/4627/focus-changer/ # Change focus b/w windows w/ keyboard

  # --- Mime Types -----------------------------------------
  # Common: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
  #    All: https://www.iana.org/assignments/media-types/media-types.xhtml
  xdg.mimeApps.defaultApplications =
    let
      calendar = [ "org.gnome.Calendar.desktop" ];
      email-client = [ "thunderbird.desktop" ];
      text-editor = [ "org.gnome.TextEditor.desktop" ];
      web-browser = [ "firefox.desktop" "org.gnome.Epiphany.desktop" ];
    in
    {
      # --- Browser ---
      "x-scheme-handler/http" = web-browser;
      "x-scheme-handler/https" = web-browser;
      "application/xhtml+xml" = web-browser;
      "text/html" = web-browser;
      # --- Communication ---
      "x-scheme-handler/mailto" = email-client;
      "text/calendar" = calendar;
      # --- Text Editor ---
      "text/plain" = text-editor;
    };
}
#xdg.mimeApps.defaultApplications = let
#  # --- Libs: setDefault ---
#  #setDefaultApp = mimeTypes: appList: lib.lists.foldl (x: y: x // { "${y}" = appList; }) {};
#  setDefaultApp = mimeTypes: appList: lib.attrsets.genAttrs mimeTypes (mimeType: appList);
#  setDefaultBrowser = setDefaultApp [
#    "x-scheme-handler/http"  "application/xhtml+xml"
#    "x-scheme-handler/https" "text/html"
#  ];
#  setDefaultAppBrowser = appList: {
#    "x-scheme-handler/http"  = appList; "application/xhtml+xml"  = appList;
#    "x-scheme-handler/https" = appList; "text/html"              = appList;
#  };
#  setDefaultAppMail = appList: {
#    "x-scheme-handler/mailto" = appList;
#  };
#  setDefaultAppCalendar = appList: {
#    "text/calendar" = appList;
#  };
#  setDefaultAppMusic = appList: {
#    "audio/x-vorbis+ogg" = appList;
#    "audio/mpeg" = appList;
#    "audio/wav" = appList;
#    "audio/x-aac" = appList;
#    "audio/x-aiff" = appList;
#    "audio/x-ape" = appList;
#    "audio/x-flac" = appList;
#    "audio/x-m4a" = appList;
#    "audio/x-m4b" = appList;
#    "audio/x-mp1" = appList;
#    "audio/x-mp2" = appList;
#    "audio/x-mp3" = appList;
#    "audio/x-mpg" = appList;
#    "audio/x-mpeg" = appList;
#    "audio/x-mpegurl" = appList;
#    "audio/x-opus+ogg" = appList;
#    "audio/x-pn-aiff" = appList;
#    "audio/x-pn-au" = appList;
#    "audio/x-pn-wav" = appList;
#    "audio/x-speex" = appList;
#    "audio/x-vorbis" = appList;
#    "audio/x-wavpack" = appList;
#  };
#  setDefaultVideo = setDefaultApp (lib.lists.map (ft: "video/${ft}") [
#    "3gp"     "3gpp" "3gpp2"
#    "dv"      "divx" "vnd.divx"
#    "fli"     "flv"  "x-flc" "x-fli" "x-flic" "x-flv"
#    "mp4"     "mp4v-es" "mp2t" "x-m4v"
#    "mpeg"    "mpeg-system" "vnd.mpegurl" "x-mpeg" "x=mjpeg"
#    "msvideo" "x-msvideo" "x-ms-asf" "x-ms-asf-plugin" "x-ms-asx" "x-ms-wm" "x-ms-wmv" "x-ms-wmx" "x-ms-wvx"
#    "ogg"     "x-ogm+ogg"
#    "quicktime"
#    "vivo" "vnd.vivo"
#    "rn-realvideo"
#    "webm" "x-anim"
#    "x-matroska" "x-nsv" "x-theora" "x-theora+ogg"
#    #"x-totem-stream"
#  ]);
#  setDefaultAppVideo = appList: {
#    "video/x-ogm+ogg" = appList;
#    "video/3gp" = appList;
#    "video/3gpp" = appList;
#    "video/3gpp2" = appList;
#    "video/dv" = appList;
#    "video/divx" = appList;
#    "video/fli" = appList;
#    "video/flv" = appList;
#    "video/mp2t" = appList;
#    "video/mp4" = appList;
#    "video/mp4v-es" = appList;
#    "video/mpeg" = appList;
#    "video/mpeg-system" = appList;
#    "video/msvideo" = appList;
#    "video/ogg" = appList;
#    "video/quicktime" = appList;
#    "video/vivo" = appList;
#    "video/vnd.divx" = appList;
#    "video/vnd.mpegurl" = appList;
#    "video/vnd.rn-realvideo" = appList;
#    "video/vnd.vivo" = appList;
#    "video/webm" = appList;
#    "video/x-anim" = appList;
#    "video/x-avi" = appList;
#    "video/x-flc" = appList;
#    "video/x-fli" = appList;
#    "video/x-flic" = appList;
#    "video/x-flv" = appList;
#    "video/x-m4v" = appList;
#    "video/x-matroska" = appList;
#    "video/x-mjpeg" = appList;
#    "video/x-mpeg" = appList;
#    "video/x-mpeg2" = appList;
#    "video/x-ms-asf" = appList;
#    "video/x-ms-asf-plugin" = appList;
#    "video/x-ms-asx" = appList;
#    "video/x-msvideo" = appList;
#    "video/x-ms-wm" = appList;
#    "video/x-ms-wmv" = appList;
#    "video/x-ms-wmx" = appList;
#    "video/x-ms-wvx" = appList;
#    "video/x-nsv" = appList;
#    "video/x-theora" = appList;
#    "video/x-theora+ogg" = appList;
#    "video/x-totem-stream" = appList;
#  };
#  setDefaultAppPhotos = appList: {
#    "image/jpeg" = appList;
#    "image/bmp" = appList;
#    "image/gif" = appList;
#    "image/jpg" = appList;
#    "image/pjpeg" = appList;
#    "image/png" = appList;
#    "image/tiff" = appList;
#    "image/webp" = appList;
#    "image/x-bmp" = appList;
#    "image/x-gray" = appList;
#    "image/x-icb" = appList;
#    "image/x-ico" = appList;
#    "image/x-png" = appList;
#    "image/x-portable-anymap" = appList;
#    "image/x-portable-bitmap" = appList;
#    "image/x-portable-graymap" = appList;
#    "image/x-portable-pixmap" = appList;
#    "image/x-xbitmap" = appList;
#    "image/x-xpixmap" = appList;
#    "image/x-pcx" = appList;
#    "image/svg+xml" = appList;
#    "image/svg+xml-compressed" = appList;
#    "image/vnd.wap.wbmp" = appList;
#    "image/x-icns" = appList;
#  };
#  setDefaultTextEditor = appList: {
#    "text/plain" = appList;
#  };
#  mimes = mimeList: lib.attrsets.genAttrs mimeList (mt: mt);
#  prefixedMime = prefix: mimeList: lib.attrsets.genAttrs (lib.lists.forEach (mt: "${prefix}/${mt}") mimeList);
#  #prefixedMime = prefix: builtins.zipAttrsWith (key: values: { "${prefix}/${key}" = values; });
#  setBrowsers = prefixedMime builtins.zipAttrsWith (key: values: values ];
#in lib.attrsets.recursiveMerge (
#  #setDefaultBrowser [ "org.gnome.Epiphany.desktop" ]
#  setDefaultBrowser [ "firefox.desktop" "org.gnome.Epiphany.desktop" ]
#  setDefaultAppPhotos [ "org.gnome.eog.desktop" "org.gnome.Loupe.desktop" "com.belmoussaoui.Obfuscate" ]
#  setDefaultAppVideo  [ "org.gnome.Totem.desktop" "com.github.rafostar.Clapper.desktop" ]
#);
#in lib.attrsets.recursiveUpdate {
#
#}
