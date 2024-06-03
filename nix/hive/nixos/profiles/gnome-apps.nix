{ inputs, cell, config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.authenticator            # GTK4 Two-Factor Auth code generator
    pkgs.gnome.gnome-software     # Default: services.flatpak.enable=true
      # --- Developer ---
      #pkgs.gitg             # GTK GUI client for Git repos
      #pkgs.commit           # GTK commit editor. Note: Not yet packaged in nixpkgs
      #pkgs.forge-sparks     # Watcher & notifier for Git repos. Note: Not packaged yet in nixpkgs
      #pkgs.gnome.accerciser # Accessibility
      ##pkgs.gnome.anjuta    # Software dev studio (old)
      #pkgs.gnome.devhelp    # API doc browser
      #pkgs.gnome-builder
      #pkgs.gnome-doc-utils
      #pkgs.gnome-keysign
      #pkgs.nautilus-python

      # --- Email ---
      # TODO: Package erooster-mail/email-client
      # https://github.com/erooster-mail/email-client
      # TODO: Move to home-manager?
      pkgs.thunderbird

      # --- Remote ---
      # TODO: Move to home-manager
      pkgs.remmina
      pkgs.gnomeExtensions.remmina-search-provider

  ];
  # ++ lib.optional inputs.nix-software-center.packages.${pkgs.system}.default

  # --- Evolution ---
  # TODO: Fix EWS support for Microsoft Exchange & Microsoft Graph API
  #programs.evolution = {
  #  enable = true;
  #  plugins = [pkgs.evolution-ews];
  #};
  #services.gnome.evolution-data-server = {
  #  enable = true;
  #  plugins = [pkgs.evolution-ews];
  #};


  services.gnome = {
    core-developer-tools.enable = lib.mkDefault true;
    core-utilities.enable       = lib.mkDefault true;
    games.enable                = lib.mkDefault true;
    sushi.enable = true;                 # Nautilus previewer
  };
}
