{ config, lib, pkgs, ... }:
{
  services.gnome = {
    core-developer-tools.enable = true;
    core-utilities.enable = true;
    gnome-remote-desktop.enable = true;
  };

  # Default apps for GNOME configuration
  # TODO: Add GNOME / GTK / Adwaita dev tools & apps
  environment.systemPackages = [
    #pkgs.gitg         # GTK GUI client for Git repos
    #pkgs.commit       # GTK commit editor. Note: Not yet packaged in nixpkgs
    #pkgs.forge-sparks # Watcher & notifier for Git repos. Note: Not packaged yet in nixpkgs
    #pkgs.accerciser   # Accessibility
    ##pkgs.anjuta      # Software dev studio (old)
    #pkgs.devhelp      # API doc browser
    #pkgs.seahorse     # GUI to manage encryption keys & passwords in GNOME keyring
    #pkgs.gnome-terminal
    #pkgs.gnome-builder
    #pkgs.gnome-console
    #pkgs.gnome-doc-utils
    #pkgs.gnome-keysign

    #pkgs.nautilus-python
  ];
}
