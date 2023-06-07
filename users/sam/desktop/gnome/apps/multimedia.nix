{ self, inputs, config, lib, pkgs,
  ...
}:
{
  imports = [
    ../../../media.nix
  ];

  # TODO: Split into media-playback, media-editors, reading
  home.packages = [

    # --- Audio Capture ------
    pkgs.gnome.gnome-sound-recorder  # Recorder app

    # --- Audio Editors ------
    pkgs.eartag                      # Music tag editor
    pkgs.tenacity                    # Audacity fork  # TODO: Move to DE-agnostic profile

    # --- Audio Players ------
    pkgs.amberol                     # Local music player
    pkgs.cavalier                    # Music visualizer
    pkgs.gnome-podcasts              # Listen to podcasts


    # --- Photo Capture ------
    pkgs.megapixels                  # GNOME camera app
    #pkgs.snapshot                   # new GNOME camera app

    # --- Photo Editors ------
    pkgs.curtail                     # Image compressor
    pkgs.gimp-with-plugins           # Image editing suite
    pkgs.gnome-obfuscate             # Remove metadata from images
    pkgs.imaginer                    # Create images using ML

    # --- Photo Viewers ------
    #pkgs.loupe                      # New GTK4 default image viewer for GNOME (not in nixpkgs yet)


    # --- Video Capture ------

    # --- Video Editors ------
    pkgs.video-trimmer               # GTK4 video trimming app

    # --- Video Players ------
    pkgs.clapper                     # GTK4 video player
    #pkgs.gnomecast                   # Chromecast support in GNOME (broken)
  ];

}
