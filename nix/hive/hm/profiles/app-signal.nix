{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.signal-desktop
    pkgs.nur.repos.dschrempf.signal-back # Decrypt Signal backups
    pkgs.nur.repos.mic92.signald # Daemon for programs to interface w/ Signal
  ] ++ lib.optionals config.gtk.enable [
    pkgs.flare-signal
    #pkgs.axolotl
  ];

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
