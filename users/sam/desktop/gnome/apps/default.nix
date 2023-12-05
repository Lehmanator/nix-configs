{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    # --- Distro-independent Apps ---
    # TODO: Import same category files from `../../apps` in `./<category>.nix`
    ../../apps

    # --- Categories ---
    ./chat.nix
    ./dbus.nix
    ./developer.nix
    ./multimedia.nix
    ./productive.nix
    #./office.nix
    ./reading.nix
    ./security.nix
    #./settings
    ./social.nix

    # --- Individual Apps ---
    # TODO: Move all apps to use dir structure: `./<appName>/{default,settings}.nix`
    # TODO: Use `./<category>.nix` to import these.
    ./amberol
    ./decibels
    ./gnome-calculator
    ./gradience
    ./loupe
    ./valent
    ./vaults

  ];

  # TODO: Package updated GNOME apps
  # https://gitlab.gnome.org/GNOME/gnome-system-monitor/-/merge_requests/55 # GNOME System Monitor w/ GTK4
  # https://gitlab.gnome.org/World/warp # File transfer
  # https://gitlab.gnome.org/GNOME/gnome-calendar/
  # https://flathub.org/apps/details/de.schmidhuberj.Flare
  # https://gitlab.gnome.org/GNOME/sysprof
  #
  # TODO: Package new GNOME apps
  # https://github.com/kaii-lb/overskride # Bluetooth config
  # https://github.com/kra-mo/cartridges  # Game launcher
  # https://github.com/fkinoshita/Wildcard # Regex tester
  # https://github.com/sonnyp/Workbench/ # GTK IDE
  # https://apps.gnome.org/PdfMetadataEditor/ # Edit document metadata
  # https://flathub.org/apps/com.vixalien.decibels # Audio file player with waveform
  # https://github.com/flattool/warehouse # Manages installed flatpaks, their data, & flatpak remotes
  # https://framagit.org/tractor/carburetor # Connect to TOR
  # https://flathub.org/apps/com.belmoussaoui.snowglobe # QEMU viewer over DBus
  # https://gitlab.gnome.org/philippun1/turtle # Manage Git repos in Nautilus (Nautilus extension)
  # https://github.com/mijorus/smile # Emoji picker
  # https://github.com/Diego-Ivan/Flowtime # Time tracker
  # https://github.com/sonnyp/Commit # Write Git commit messages
  # https://gitlab.gnome.org/World/chess-clock # Chess clock
  # https://gitlab.gnome.org/World/apostrophe # Markdown editor
  # https://flathub.org/apps/com.mardojai.DiccionarioLengua # Spanish dictionary
  # https://flathub.org/apps/io.gitlab.theevilskeleton.Upscaler # Image upscaler
  # https://bavarder.codeberg.page/ # Multi-chatbot UI
  # https://github.com/aleiepure/ticketbooth # TV Show viewer w/ TMDB API
  # https://gitlab.gnome.org/philippun1/snoop # GUI tool to search thru files w/ Nautilus extension
  # https://gdm-settings.github.io/ # Configure GDN login screen
  # https://github.com/tchx84/Flatseal # Modify flatpak permissions & sandboxing
  # https://codeberg.org/baarkerlounger/jogger # Fitness tracker
  # https://gitlab.com/gregorni/Letterpress # ASCII art maker
  #https://flathub.org/apps/details/org.nickvision.cavalier
  #https://flathub.org/apps/details/org.nickvision.tubeconverter
  #https://apps.gnome.org/Impression/ # USB flasher
  #https://flathub.org/apps/io.gitlab.gwendalj.package-transporter # Flatpak data backup & migration
  #https://github.com/bragefuglseth/fretboard # Lookup guitar chords
  #https://flathub.org/apps/io.gitlab.daikhan.stable
  #https://github.com/Nokse22/ascii-draw
  #
  # TODO: Package updated GNOME extensions
  # https://extensions.gnome.org/extension/5660/weather-or-not/ # (Updated to fix duplicate icon)
  #
  # TODO: Package new GNOME extensions
  # https://extensions.gnome.org/extension/5500/auto-activities/ # Show activities when no windows
  # https://extensions.gnome.org/extension/4627/focus-changer/ # Change focus b/w windows w/ keyboard

  # --- Install GTK4 Apps ---
  # TODO: Figure out apps loaded elsewhere & remove
  home.packages = with pkgs; [
    authenticator
    aviator # Merge JSON/YAML files
    bleachbit # Clean your computer
    boatswain # Control Elgato Stream Deck devices
    cambalache # Rapid Application Development for GTK4 / GTK3
    celeste # File sync client for multiple cloud providers
    cobang # QR code scanner
    czkawka # Remove unnecessary files
    denaro # Personal finance manager
    dialect # Translator
    dynamic-wallpaper # Create dynamic wallpapers for GNOME
    eartag # Music tag editor
    elastic # Design spring animations
    emblem # Generate project icons & avatars from a symbolic icon
    endeavour # Personal task manager for GNOME
    formiko # reStructuredText editor & live preview
    fragments # Torrent client
    gaphor # Simple modeling tool
    gnome-builder # IDE for GNOME
    gnome-decoder # QR code scanner & creator
    gnome-extension-manager # Manage GNOME Shell extensions w/ search & install functionality
    gnome-secrets # Password manager for GNOME using KeePass v4 format
    halftone # Give images pixel-art style
    icon-library # Symbolic icon catalog
    identity # Compare multiple versions of an image or video
    livecaptions # Provides live captioning
    gnomeExtensions.live-captions-assistant # Extension to provide better desktop integration with GNOME
    metadata-cleaner # Remove metadata from files
    mousai # Identify playing music
    pika-backup # Backup application
    #portfolio-filemanager # Mobile-first file manager
    rnote # Handwritten notes
    schemes # Create / edit syntax highlighting style-schemes for GtkSourceView
    symbolic-preview # Create, preview, export symbolic icons easily
    tagger # Music tag editor
    tangram # Run web apps in tabbed app-like client
    video-trimmer # Trim videos
    warp # QR code file transfer
    wike # Wikipedia client

    celeste # File synchronization app supporting Google Drive, Dropbox, Nextcloud, OwnCloud, WebDAV. (Future: OneDrive, Amazon S3)
    contrast # Check contrast & colorscheme accessibility (WCAG requirements)
    emulsion-palette # Store color palettes
    eyedropper # Color picker & formatter
    #obs-studio       # Streaming & video recording suite
    #  obs-studio-plugins.obs-3d-effect wlrobs obs-ndi obs-vaapi obs-nvfbc obs-teleport obs-hyperion droidcam-obs obs-vkcapture obs-gstreamer input-overlay multi-rtmp obs-source-clone obs-shaderfilter obs-source-record obs-livesplit-one looking-glass-obs obs-vintage-filter obs-command-source obs-move-transition obs-backgroundremoval advanced-scene-switcher obs-pipewire-audio-capture
    paleta # Generate color paletes
    #pods             # Podman desktop application
    sticky # Sticky Notes app

    #amberol # Music player
    #cawbird          # Twitter client (deprecated?)
    #dino             # Jabber/XMPP client
    #flare-signal     # Unofficial Signal client
    #gradience # App to theme GNOME, GTK, & various apps according to palettes or wallpapers
    #tuba             # Fediverse / Mastodon client
  ];

  # --- Mime Types -----------------------------------------
  # Common: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
  #    All: https://www.iana.org/assignments/media-types/media-types.xhtml
  xdg.mimeApps.defaultApplications =
    let
      audio-player = [ "com.vixalien.decibels.desktop" "io.bassi.Amberol.desktop" ];
      music-player = [ "io.bassi.Amberol.desktop" ];
      calendar = [ "org.gnome.Calendar.desktop" ];
      email-client = [ "thunderbird.desktop" ];
      image-viewer = [ "org.gnome.Loupe.desktop" "org.gnome.eog.desktop" ];
      video-viewer = [ "org.gnome.Totem.desktop" ];
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

      # --- Audio ---
      "audio/x-vorbis+ogg" = audio-player;
      "audio/mpeg" = audio-player;
      "audio/wav" = audio-player;
      "audio/x-aac" = audio-player;
      "audio/x-aiff" = audio-player;
      "audio/x-ape" = audio-player;
      "audio/x-flac" = audio-player;
      "audio/x-m4a" = audio-player;
      "audio/x-m4b" = audio-player;
      "audio/x-mp1" = audio-player;
      "audio/x-mp2" = audio-player;
      "audio/x-mp3" = audio-player;
      "audio/x-mpg" = audio-player;
      "audio/x-mpeg" = audio-player;
      "audio/x-mpegurl" = audio-player;
      "audio/x-opus+ogg" = audio-player;
      "audio/x-pn-aiff" = audio-player;
      "audio/x-pn-au" = audio-player;
      "audio/x-pn-wav" = audio-player;
      "audio/x-speex" = audio-player;
      "audio/x-vorbis" = audio-player;
      "audio/x-wavpack" = audio-player;

      # --- Images ---
      "image/jpeg" = image-viewer;
      "image/bmp" = image-viewer;
      "image/gif" = image-viewer;
      "image/jpg" = image-viewer;
      "image/pjpeg" = image-viewer;
      "image/png" = image-viewer;
      "image/tiff" = image-viewer;
      "image/webp" = image-viewer;
      "image/x-bmp" = image-viewer;
      "image/x-gray" = image-viewer;
      "image/x-icb" = image-viewer;
      "image/x-ico" = image-viewer;
      "image/x-png" = image-viewer;
      "image/x-portable-anymap" = image-viewer;
      "image/x-portable-bitmap" = image-viewer;
      "image/x-portable-graymap" = image-viewer;
      "image/x-portable-pixmap" = image-viewer;
      "image/x-xbitmap" = image-viewer;
      "image/x-xpixmap" = image-viewer;
      "image/x-pcx" = image-viewer;
      "image/svg+xml" = image-viewer;
      "image/svg+xml-compressed" = image-viewer;
      "image/vnd.wap.wbmp" = image-viewer;
      "image/x-icns" = image-viewer;

      # --- Video --
      "video/x-ogm+ogg" = video-viewer;
      "video/3gp" = video-viewer;
      "video/3gpp" = video-viewer;
      "video/3gpp2" = video-viewer;
      "video/dv" = video-viewer;
      "video/divx" = video-viewer;
      "video/fli" = video-viewer;
      "video/flv" = video-viewer;
      "video/mp2t" = video-viewer;
      "video/mp4" = video-viewer;
      "video/mp4v-es" = video-viewer;
      "video/mpeg" = video-viewer;
      "video/mpeg-system" = video-viewer;
      "video/msvideo" = video-viewer;
      "video/ogg" = video-viewer;
      "video/quicktime" = video-viewer;
      "video/vivo" = video-viewer;
      "video/vnd.divx" = video-viewer;
      "video/vnd.mpegurl" = video-viewer;
      "video/vnd.rn-realvideo" = video-viewer;
      "video/vnd.vivo" = video-viewer;
      "video/webm" = video-viewer;
      "video/x-anim" = video-viewer;
      "video/x-avi" = video-viewer;
      "video/x-flc" = video-viewer;
      "video/x-fli" = video-viewer;
      "video/x-flic" = video-viewer;
      "video/x-flv" = video-viewer;
      "video/x-m4v" = video-viewer;
      "video/x-matroska" = video-viewer;
      "video/x-mjpeg" = video-viewer;
      "video/x-mpeg" = video-viewer;
      "video/x-mpeg2" = video-viewer;
      "video/x-ms-asf" = video-viewer;
      "video/x-ms-asf-plugin" = video-viewer;
      "video/x-ms-asx" = video-viewer;
      "video/x-msvideo" = video-viewer;
      "video/x-ms-wm" = video-viewer;
      "video/x-ms-wmv" = video-viewer;
      "video/x-ms-wmx" = video-viewer;
      "video/x-ms-wvx" = video-viewer;
      "video/x-nsv" = video-viewer;
      "video/x-theora" = video-viewer;
      "video/x-theora+ogg" = video-viewer;
      #"video/x-totem-stream" = video-viewer;
    };
}

# Set default apps
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
