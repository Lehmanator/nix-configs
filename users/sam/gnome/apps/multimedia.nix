{ inputs
, osConfig
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./audio-recorders.nix
    #./audio-editors.nix
    #./audio-players.nix
    ./amberol
    ./cozy
    ./decibels

    #./photo-recorders.nix
    #./photo-editors.nix
    #./photo-players.nix
    ./loupe # GNOME's new GTK4 default image viewer

    #./video-recorders.nix
    #./video-editors.nix
    #./video-players.nix
  ];

  # TODO: Only enable mobile-friendly apps on phones/tablets
  # TODO: Split into media-playback, media-editors, reading
  home.packages = [
    pkgs.variety #                  # Wallpaper manager

    # --- Download -----------------------------------------
    pkgs.fragments #                # Torrent client

    # --- Audio --------------------------------------------
    # --- Capture ------
    pkgs.gnome.gnome-sound-recorder # Recorder app
    pkgs.mousai #                   # Identify playing music
    #pkgs.recapp #                  # GTK audio recorder & screencaster
    # --- Edit ------
    pkgs.eartag #                   # Music tag editor
    pkgs.tagger #                   # Music tag editor
    pkgs.tenacity #                 # Audacity fork  # TODO: Move to DE-agnostic profile
    pkgs.zrythm #                   # Digital audio workstation
    # --- View ------
    pkgs.blanket #                  # Listen to sounds
    pkgs.cavalier #                 # Music visualizer
    pkgs.gnome-podcasts #           # Listen to podcasts
    pkgs.lollypop #                 # Music player for GNOME
    pkgs.parlatype #                # Audio player for transcription
    pkgs.spot #                     # GTK4 Spotify client
    pkgs.ymuse #                    # GTK frontend for MPD

    # --- Photos -------------------------------------------
    # --- Capture ---
    pkgs.cobang #                   # QR code scanner
    pkgs.gnome.cheese #             # GNOME camera app (old)
    pkgs.gnome-decoder #            # GNOME QR code scanner & creator
    pkgs.megapixels #               # GNOME camera app (mobile)
    pkgs.snapshot #                 # GNOME camera app (new)
    # --- Edit ------
    pkgs.curtail #                  # Image compressor
    pkgs.drawing #                  # GNOME MS Paint
    pkgs.gnome-obfuscate #          # Remove metadata from images
    pkgs.halftone #                 # Give images pixel-art style
    pkgs.image-roll #               # Basic GTK image viewer/editor
    pkgs.imaginer #                 # Create images using ML
    # --- View ------
    pkgs.identity #                 # Compare multiple versions of an image or video

    # --- Videos -------------------------------------------
    # --- Capture ------
    #pkgs.obs-studio #              # Streaming & video recording suite
    #  obs-studio-plugins.obs-3d-effect wlrobs obs-ndi obs-vaapi obs-nvfbc obs-teleport obs-hyperion droidcam-obs obs-vkcapture obs-gstreamer input-overlay multi-rtmp obs-source-clone obs-shaderfilter obs-source-record obs-livesplit-one looking-glass-obs obs-vintage-filter obs-command-source obs-move-transition obs-backgroundremoval advanced-scene-switcher obs-pipewire-audio-capture
    # --- Edit ------
    pkgs.video-trimmer #            # GTK4 video trimming app
    # --- View ------
    pkgs.clapper #                  # GTK4 video player
    #pkgs.gnomecast #               # Chromecast support in GNOME (broken)

  ] ++ lib.optionals (pkgs.system == "x86_64-linux") [

    # --- Photo Editors ---
    pkgs.gimp-with-plugins #        # Image editing suite
    pkgs.inkscape-with-extensions # # Vector graphics editor
    pkgs.krita #                    # Painting app
    # --- Video Editors ---
    pkgs.blender #                  # 3D modeling & video rendering
    pkgs.boatswain #                # Control Elgato Stream Deck devices
    pkgs.losslesscut-bin #          # Swiss army knife of video editing
    pkgs.pitivi #                   # Create/edit your own movies   # librosa dep broken 2023-08-14
    pkgs.shotcut #                  # Video editor
    #pkgs.natron #                  # Node-graph based compositing software

  ] ++ lib.optionals (osConfig ? "services" && osConfig.services.pipewire.enable && (config.gtk.enable || osConfig.gtk.enable)) [
    pkgs.easyeffects #              # Audio effects for PipeWire apps
    pkgs.helvum #    #              # GTK patchbay for Pipewire
  ];

  #https://github.com/bragefuglseth/fretboard #                  # Lookup guitar chords
  #https://github.com/Nokse22/ascii-draw #                       # ASCII art maker
  #https://github.com/aleiepure/ticketbooth #                    # TV Show viewer w/ TMDB API
  #https://gitlab.com/gregorni/Letterpress #                     # ASCII art maker
  #https://flathub.org/apps/com.vixalien.decibels #              # Audio file player with waveform
  #https://flathub.org/apps/details/org.nickvision.cavalier #    # Audio visualizer
  #https://flathub.org/apps/details/org.nickvision.tubeconverter
  #https://flathub.org/apps/io.gitlab.theevilskeleton.Upscaler # # Image upscaler

  # --- Mime Types -----------------------------------------
  # Common: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
  #    All: https://www.iana.org/assignments/media-types/media-types.xhtml
  xdg.mimeApps.defaultApplications =
    let
      audio-player = [ "com.vixalien.decibels.desktop" "io.bassi.Amberol.desktop" ];
      music-player = [ "io.bassi.Amberol.desktop" ];
      image-viewer = [ "org.gnome.Loupe.desktop" "org.gnome.eog.desktop" ];
      video-viewer = [ "org.gnome.Totem.desktop" ];
    in
    {
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
