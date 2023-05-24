{ self, inputs,
  config, lib, pkgs,
  ...
}:
let
  #setDefaultApp = mimeTypes: appList: lib.lists.foldl (x: y: x // { "${y}" = appList; }) {};
  setDefaultApp = mimeTypes: appList: lib.attrsets.genAttrs mimeTypes (mimeType: appList);
  setDefaultBrowser = setDefaultApp [
    "x-scheme-handler/http"  "application/xhtml+xml"
    "x-scheme-handler/https" "text/html"
  ];
  setDefaultAppBrowser = appList: {
    "x-scheme-handler/http"  = appList; "application/xhtml+xml"  = appList;
    "x-scheme-handler/https" = appList; "text/html"              = appList;
  };
  setDefaultAppMail = appList: {
    "x-scheme-handler/mailto" = appList;
  };
  setDefaultAppCalendar = appList: {
    "text/calendar" = appList;
  };
  setDefaultAppMusic = appList: {
    "audio/x-vorbis+ogg" = appList;
    "audio/mpeg" = appList;
    "audio/wav" = appList;
    "audio/x-aac" = appList;
    "audio/x-aiff" = appList;
    "audio/x-ape" = appList;
    "audio/x-flac" = appList;
    "audio/x-m4a" = appList;
    "audio/x-m4b" = appList;
    "audio/x-mp1" = appList;
    "audio/x-mp2" = appList;
    "audio/x-mp3" = appList;
    "audio/x-mpg" = appList;
    "audio/x-mpeg" = appList;
    "audio/x-mpegurl" = appList;
    "audio/x-opus+ogg" = appList;
    "audio/x-pn-aiff" = appList;
    "audio/x-pn-au" = appList;
    "audio/x-pn-wav" = appList;
    "audio/x-speex" = appList;
    "audio/x-vorbis" = appList;
    "audio/x-wavpack" = appList;
  };
  setDefaultAppVideo = appList: {
    "video/x-ogm+ogg" = appList;
    "video/3gp" = appList;
    "video/3gpp" = appList;
    "video/3gpp2" = appList;
    "video/dv" = appList;
    "video/divx" = appList;
    "video/fli" = appList;
    "video/flv" = appList;
    "video/mp2t" = appList;
    "video/mp4" = appList;
    "video/mp4v-es" = appList;
    "video/mpeg" = appList;
    "video/mpeg-system" = appList;
    "video/msvideo" = appList;
    "video/ogg" = appList;
    "video/quicktime" = appList;
    "video/vivo" = appList;
    "video/vnd.divx" = appList;
    "video/vnd.mpegurl" = appList;
    "video/vnd.rn-realvideo" = appList;
    "video/vnd.vivo" = appList;
    "video/webm" = appList;
    "video/x-anim" = appList;
    "video/x-avi" = appList;
    "video/x-flc" = appList;
    "video/x-fli" = appList;
    "video/x-flic" = appList;
    "video/x-flv" = appList;
    "video/x-m4v" = appList;
    "video/x-matroska" = appList;
    "video/x-mjpeg" = appList;
    "video/x-mpeg" = appList;
    "video/x-mpeg2" = appList;
    "video/x-ms-asf" = appList;
    "video/x-ms-asf-plugin" = appList;
    "video/x-ms-asx" = appList;
    "video/x-msvideo" = appList;
    "video/x-ms-wm" = appList;
    "video/x-ms-wmv" = appList;
    "video/x-ms-wmx" = appList;
    "video/x-ms-wvx" = appList;
    "video/x-nsv" = appList;
    "video/x-theora" = appList;
    "video/x-theora+ogg" = appList;
    "video/x-totem-stream" = appList;
  };
  setDefaultAppPhotos = appList: {
    "image/jpeg" = appList;
    "image/bmp" = appList;
    "image/gif" = appList;
    "image/jpg" = appList;
    "image/pjpeg" = appList;
    "image/png" = appList;
    "image/tiff" = appList;
    "image/webp" = appList;
    "image/x-bmp" = appList;
    "image/x-gray" = appList;
    "image/x-icb" = appList;
    "image/x-ico" = appList;
    "image/x-png" = appList;
    "image/x-portable-anymap" = appList;
    "image/x-portable-bitmap" = appList;
    "image/x-portable-graymap" = appList;
    "image/x-portable-pixmap" = appList;
    "image/x-xbitmap" = appList;
    "image/x-xpixmap" = appList;
    "image/x-pcx" = appList;
    "image/svg+xml" = appList;
    "image/svg+xml-compressed" = appList;
    "image/vnd.wap.wbmp" = appList;
    "image/x-icns" = appList;
  };
in
{
  imports = [
    ./chat.nix
    ./dbus.nix
    ./developer.nix
    ./multimedia.nix
    ./phone.nix
    ./productive.nix
    #./office.nix
    ./reading.nix
    ./security.nix
    #./settings
    ./social.nix


    # --- Individual Apps ---
    ./gnome-calculator.nix
    ./vaults.nix

  ];

  home.packages = [
    pkgs.tangram          # Launcher/browser for web apps
  ];

  # Set default apps
  xdg.mimeApps.defaultApplications = (
    setDefaultBrowser [ "org.gnome.Epiphany.desktop" ]
  );

}
