{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # Daemon to control MPRIS audio (browsers, mpd, etc.)
  services.playerctld.enable = true;

  #services.plex-mpv-shim = {
  #  enable = true;
  #  package = pkgs.plex-mpv-shim;
  #  # See: https://github.com/iwalton3/plex-mpv-shim/blob/master/README.md
  #  settings = {
  #    adaptive_transcode = true;
  #    allow_http = false;
  #    always_transcode = null;
  #    audio_ac3passthrough = null;
  #    audio_dtspassthrough = null;
  #    auto_play = false;
  #    auto_transcode = false;
  #  };
  #};

}
