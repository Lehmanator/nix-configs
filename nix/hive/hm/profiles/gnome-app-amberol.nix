{ config , lib , pkgs , ... }: {
  home.packages = [ pkgs.amberol ];
  xdg.mimeApps.defaultApplications = {
    "audio/mpeg" = [ "io.bassi.Amberol.desktop" ];
    "audio/wav" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-aac" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-aiff" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-ape" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-flac" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-m4a" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-m4b" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-mp1" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-mp2" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-mp3" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-mpeg" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-mpegurl" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-mpg" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-opus+ogg" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-pn-aiff" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-pn-au" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-pn-wav" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-speex" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-vorbis" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-vorbis+ogg" = [ "io.bassi.Amberol.desktop" ];
    "audio/x-wavpack" = [ "io.bassi.Amberol.desktop" ];
  };

}
