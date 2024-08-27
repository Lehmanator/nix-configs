{ inputs , cell , config , lib , pkgs , ... }:
{
  imports = [ cell.homeProfiles.gnome-app-vaults ];

  home.packages = [
    pkgs.authenticator #  # 2-Factor authenticator
    pkgs.gnome-keysign #  # Sign GPG keys
    pkgs.gnome-secrets #  # GTK4 password manager using KeePass v4 format
    pkgs.metadata-cleaner # Remove metadata from files

    # --- Non-GTK ---
    pkgs.bleachbit #      # Wipe disks
  ];

  # Connect to TOR
  # TODO: Package app: cell.packages.gnome-app-carburetor
  # https://framagit.org/tractor/carburetor
}
