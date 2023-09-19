{ self, inputs, config, lib, pkgs,
  ...
}:
{
  imports = [
    ../../../media.nix
  ];

  # TODO: Split into media-playback, media-editors, reading
  home.packages = [
    pkgs.variety                     # Wallpaper manager

    # --- Audio Capture ------
    pkgs.easyeffects                 # Audio effects for PipeWire apps
    pkgs.gnome.gnome-sound-recorder  # Recorder app
    pkgs.helvum                      # GTK patchbay for Pipewire
    pkgs.recapp                      # GTK audio recorder & screencaster

    # --- Audio Editors ------
    pkgs.eartag                      # Music tag editor
    pkgs.tagger                      # Music tag editor
    pkgs.tenacity                    # Audacity fork  # TODO: Move to DE-agnostic profile
    pkgs.zrythm                      # Digital audio workstation

    # --- Audio Players ------
    pkgs.amberol                     # Local music player
    pkgs.blanket                     # Listen to sounds
    pkgs.cavalier                    # Music visualizer
    #pkgs.cozy                        # Audiobook player
    pkgs.gnome-podcasts              # Listen to podcasts
    pkgs.lollypop                    # Music player for GNOME
    pkgs.parlatype                   # Audio player for transcription
    pkgs.spot                        # GTK4 Spotify client
    pkgs.ymuse                       # GTK frontend for MPD

    # --- Photo Capture ------
    pkgs.gnome.cheese                # Webcam capture w/ effects
    pkgs.megapixels                  # GNOME camera app
    #pkgs.snapshot                   # new GNOME camera app

    # --- Photo Editors ------
    pkgs.curtail                     # Image compressor
    pkgs.drawing                     # GNOME MS Paint
    pkgs.gimp-with-plugins           # Image editing suite
    pkgs.gnome-obfuscate             # Remove metadata from images
    pkgs.image-roll                  # Basic GTK image viewer/editor
    pkgs.imaginer                    # Create images using ML
    pkgs.inkscape-with-extensions    # Vector graphics editor
    pkgs.krita                       # Painting app

    # --- Photo Viewers ------
    #pkgs.loupe                      # New GTK4 default image viewer for GNOME (not in nixpkgs yet)


    # --- Video Capture ------

    # --- Video Editors ------
    pkgs.blender                     # 3D modeling & video rendering
    pkgs.losslesscut-bin             # Swiss army knife of video editing
    pkgs.natron                      # Node-graph based compositing software
    #pkgs.pitivi                      # Create/edit your own movies            # librosa dep broken 2023-08-14
    pkgs.shotcut                     # Video editor
    pkgs.video-trimmer               # GTK4 video trimming app

    # --- Video Players ------
    pkgs.clapper                     # GTK4 video player
    #pkgs.gnomecast                   # Chromecast support in GNOME (broken)
  ];

}
