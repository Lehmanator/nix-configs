{ config, lib, pkgs, ... }: {
  # Default apps for GNOME configuration
  imports = [
    ./dev.nix
    ./email.nix
    ./remote.nix
  ];
  environment.systemPackages = [
    pkgs.authenticator         # GTK4 Two-Factor Auth code generator
    pkgs.gnome-software        # Software center app
    pkgs.goldwarden            # Bitwarden GTK client
  ];

  programs.evince.enable = true;

  services.gnome = {
    core-utilities.enable = true;
    games.enable = lib.mkDefault true;
  };
}
