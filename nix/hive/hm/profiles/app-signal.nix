{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.signal-desktop      #-beta
    pkgs.signalbackup-tools  # Decrypt Signal backups
    pkgs.signald             # Daemon for programs to interface w/ Signal
    pkgs.signaldctl
    pkgs.signal-backup-deduplicator
    pkgs.signal-export
    pkgs.signal-cli
  ] ++ lib.optional config.gtk.enable pkgs.flare-signal
  ;

  #services.flatpak.packages = [
  # "flathub:app/org.asamk.SignalCli//stable" # Signal CLI
  # "flathub:app/org.signal.Signal//stable"
  # "flathub-beta:app/org.signal.Signal//beta"
  #];
  #++ lib.optional config.gtk.enable [
  #  "flathub:app/de.schmidhuberj.Flare//stable"
  #  #"flathub-beta:app/de.schmidhuberj.Flare//beta"
  # "flathub:app/org.nanuc.Axolotl//stable"
  #];

  # TODO: Signal protocol string handler?
}
