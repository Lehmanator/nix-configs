{ inputs, config, lib, pkgs, ... }: {
  services.mpd.enable = true;

  # TODO: Move to `../../../apps/chatterino`
  home.packages = [
    pkgs.chatterino2
    pkgs.streamlink
    # --- MPD Client ---
    # Used by chatterino to open video
    #pkgs.mpd
    #pkgs.mpdas
    #pkgs.mpdris2
    #pkgs.mpd-mpris
  ] ++ lib.optionals config.gtk.enable [ pkgs.ymuse ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = [
  #  "flathub:app/com.chatterino.chatterino//stable"
  #  "flathub-beta:app/com.chatterino.chatterino//beta"
  #  "flathub:app/com.chatterino.chatterino//nightly"
  #] ++ lib.optionals config.gtk.enable [
  #];
}
