{ self
, inputs
, config
, lib
, pkgs
, ...
}:
# Default apps for GNOME configuration
{
  imports = [
  ];

  # TODO: Add GNOME / GTK / Adwaita dev tools & apps
  environment.systemPackages = [
    #pkgs.gitg # GTK GUI client for Git repos
    #pkgs.commit # GTK commit editor. Note: Not yet packaged in nixpkgs
    #pkgs.forge-sparks # Watcher & notifier for Git repos. Note: Not packaged yet in nixpkgs
    pkgs.gnome.accerciser # Accessibility
    #pkgs.gnome.anjuta  # Software dev studio (old)
    pkgs.gnome.devhelp # API doc browser
    pkgs.gnome.gnome-terminal
    pkgs.gnome.seahorse # GUI to manage encryption keys & passwords in GNOME keyring
    pkgs.gnome-builder
    pkgs.gnome-console
    pkgs.gnome-doc-utils
    pkgs.gnome-keysign

    pkgs.nautilus-python
  ];

  services.gnome = {
    core-developer-tools.enable = true;
    core-utilities.enable = true;
    gnome-remote-desktop.enable = true;
  };
}
