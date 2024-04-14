{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.self.homeProfiles.app-gnome-vaults ];
    #./gnome-secrets

  home.packages = [
    pkgs.authenticator #  # 2-Factor authenticator
    pkgs.gnome-keysign #  # Sign GPG keys
    pkgs.gnome-secrets #  # GTK4 password manager using KeePass v4 format
    pkgs.metadata-cleaner # Remove metadata from files

    # --- Non-GTK ---
    pkgs.bleachbit #      # Wipe disks
  ];

  # https://framagit.org/tractor/carburetor #   # Connect to TOR   TODO: Package
}
