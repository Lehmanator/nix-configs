{ inputs
, config, lib, pkgs
, ...
}:
let
  prefer-flatpak = false;
  prefer-native = ! prefer-flatpak;
in
{
  imports = [ ./vaults ];
  home.packages = lib.mkIf prefer-native [
    # TODO: Package carburetor
    # https://framagit.org/tractor/carburetor 
    #pkgs.carburetor   # Connect to TOR

    pkgs.authenticator #  # 2-Factor authenticator
    pkgs.gnome-keysign #  # Sign GPG keys
    # pkgs.gnome-secrets #  # GTK4 password manager using KeePass v4 format (Broken: 2024/07/22, python3Packages.pykeepass)
    pkgs.metadata-cleaner # Remove metadata from files

    # --- Non-GTK ---
    pkgs.bleachbit #      # Wipe disks
  ];

  # TODO: Adapt NixOS module for home-manager
  # TODO: systemd unit for Goldwarden daemon
  programs.firefox.nativeMessagingHosts = [ pkgs.goldwarden ];

  services.flatpak.packages = lib.mkIf prefer-flatpak [
    "org.gnome.World.Secrets"
    "com.belmoussaoui.Authenticator"
    "org.gnome.Keysign"
    "fr.romainvigier.MetadataCleaner"
    "org.bleachbit.BleachBit"
    "io.frama.tractor.carburetor"
  ];

}
