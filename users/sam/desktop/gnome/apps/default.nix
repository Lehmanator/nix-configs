{ self, inputs,
  config, lib, pkgs,
  ...
}:
let
  # --- Libs: setDefault ---
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

    # Load distro-independent apps
    ../../apps

    # --- Individual Apps ---
    # TODO: Eventually move all apps to use dir structure like:
    # ./<appName>/default.nix
    # ./<appName>/settings.nix
    ./gnome-calculator.nix
    ./vaults.nix

  ];

  # --- Install GTK4 Apps ---
  # TODO: Figure out apps loaded elsewhere & remove
  home.packages = with pkgs; [
    authenticator
    aviator          # Merge JSON/YAML files
    boatswain        # Control Elgato Stream Deck devices
    cambalache       # Rapid Application Development for GTK4 / GTK3
    cavalier         # Audio visualizer
    #cawbird          # Twitter client (deprecated?)
    curtail          # Compress images
    denaro           # Personal finance manager
    dialect          # Translator
    #dino             # Jabber/XMPP client
    dynamic-wallpaper # Create dynamic wallpapers for GNOME
    eartag           # Music tag editor
    elastic          # Design spring animations
    emblem           # Generate project icons & avatars from a symbolic icon
    endeavour        # Personal task manager for GNOME
    #flare-signal     # Unofficial Signal client
    formiko          # reStructuredText editor & live preview
    fragments        # Torrent client
    gaphor           # Simple modeling tool
    gnome-builder    # IDE for GNOME
    gnome-extension-manager # Manage GNOME Shell extensions w/ search & install functionality
    gnome-secrets    # Password manager for GNOME using KeePass v4 format
    gradience        # App to theme GNOME, GTK, & various apps according to palettes or wallpapers
    #halftone         # Give images pixel-art style
    icon-library     # Symbolic icon catalog
    identity         # Compare multiple versions of an image or video
    livecaptions     # Provides live captioning
      gnomeExtensions.live-captions-assistant  # Extension to provide better desktop integration with GNOME
    mousai           # Identify playing music
    pika-backup      # Backup application
    portfolio-filemanager # Mobile-first file manager
    rnote            # Handwritten notes
    schemes          # Create / edit syntax highlighting style-schemes for GtkSourceView
    symbolic-preview # Create, preview, export symbolic icons easily
    tagger           # Music tag editor
    tangram          # Run web apps in tabbed app-like client
    #tuba             # Fediverse / Mastodon client
    video-trimmer    # Trim videos
    warp             # QR code file transfer
    wike             # Wikipedia client


    amberol          # Music player
    celeste          # File synchronization app supporting Google Drive, Dropbox, Nextcloud, OwnCloud, WebDAV. (Future: OneDrive, Amazon S3)
    contrast         # Check contrast & colorscheme accessibility (WCAG requirements)
    emulsion-palette # Store color palettes
    eyedropper       # Color picker & formatter
    #obs-studio       # Streaming & video recording suite
    #  obs-studio-plugins.obs-3d-effect wlrobs obs-ndi obs-vaapi obs-nvfbc obs-teleport obs-hyperion droidcam-obs obs-vkcapture obs-gstreamer input-overlay multi-rtmp obs-source-clone obs-shaderfilter obs-source-record obs-livesplit-one looking-glass-obs obs-vintage-filter obs-command-source obs-move-transition obs-backgroundremoval advanced-scene-switcher obs-pipewire-audio-capture
    paleta           # Generate color paletes
    pods             # Podman desktop application
    sticky           # Sticky Notes app
  ];

  # Set default apps
  xdg.mimeApps.defaultApplications = (
    setDefaultBrowser [ "org.gnome.Epiphany.desktop" ]
  );

}
