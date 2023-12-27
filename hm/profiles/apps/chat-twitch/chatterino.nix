{ inputs, config, lib, pkgs, ... }: {
  imports = [
    #./chatterino.nix
  ];

  services.mpd.enable = true;
  home.packages = [
    pkgs.chatterino2
    pkgs.streamlink

    # --- MPD Client ---
    # Used by chatterino to open video
    #pkgs.mpd
    #pkgs.mpdas
    #pkgs.mpdris2
    #pkgs.mpd-mpris
    pkgs.ymuse # GTK app  # TODO: Only use for GTK environments.
  ];
}
